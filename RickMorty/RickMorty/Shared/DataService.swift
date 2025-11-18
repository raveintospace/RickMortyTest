//
//  DataService.swift
//  RickMorty
//
//  Created by Uri on 13/11/25.
//

import Foundation

protocol DataServiceProtocol: Sendable {
    func fetch<T: Decodable & Sendable>(type: T.Type, url: URL?) async throws -> T
}

/// Generic Data Service for fetching and decoding data from APIs
final class DataService: DataServiceProtocol {
    
    /// Fetches data from a URL, validates the HTTP response and decodes the result
    func fetch<T: Decodable & Sendable>(type: T.Type = T.self, url: URL?) async throws -> T {
        
        guard let url = url else {
            throw RemoteDataSourceError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw RemoteDataSourceError.badServerResponse
        }
        
        let statusCode = httpResponse.statusCode
        
        // Success range
        guard (200...299).contains(statusCode) else {
            throw RemoteDataSourceError.httpError(statusCode: statusCode)
        }
        
        do {
            let result = try JSONDecoder().decode(T.self, from: data)
            return result
        } catch let error {
            throw RemoteDataSourceError.decodingError(error)
        }
    }
}

