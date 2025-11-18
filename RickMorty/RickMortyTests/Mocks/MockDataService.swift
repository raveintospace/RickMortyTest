//
//  MockDataService.swift
//  RickMorty
//
//  Created by Uri on 18/11/25.
//

import Foundation
@testable import RickMorty


final class MockDataService {
    
    enum MockedResult {
        case success(Data)
        case failure(RemoteDataSourceError)
    }
    
    var result: MockedResult
    
    // Check URL requested from DataSource
    private(set) var requestedURL: URL?
    
    init(result: MockedResult) {
        self.result = result
    }
    
    func fetch<T: Decodable>(type: T.Type = T.self, url: URL?) async throws -> T {
        
        guard let url = url else {
            throw RemoteDataSourceError.invalidURL
        }
        
        self.requestedURL = url
        
        switch result {
        case .success(let data):
            do {
                let decodedObject = try JSONDecoder().decode(T.self, from: data)
                return decodedObject
            } catch {
                throw RemoteDataSourceError.decodingError(error)
            }
        
        case .failure(let error):
            throw error
        }
    }
}
