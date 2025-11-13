//
//  CardCharacterDataSourceImpl.swift
//  RickMorty
//
//  Created by Uri on 13/11/25.
//

import Foundation

/// Actor makes this class thread-safe, as it will likely be accessed concurrently
actor CardCharacterDataSourceImpl: CardCharacterDataSourceProtocol {
    
    private let dataService: DataService
    
    init(dataService: DataService) {
        self.dataService = dataService
    }
    
    func getCardCharacters(page: Int) async throws -> CharacterPageResponse {
        
        let baseURL = APIConstants.charactersListURL
        
        guard var urlComponents = URLComponents(string: baseURL) else {
            throw RemoteDataSourceError.invalidURL
        }
        
        urlComponents.queryItems = [
            URLQueryItem(name: "page", value: "\(page)")
        ]
        
        guard let finalURL = urlComponents.url else {
            throw RemoteDataSourceError.invalidURL
        }
        
        let response = try await dataService.fetch(type: CharacterPageResponse.self, url: finalURL)
        
        return response
    }
}
