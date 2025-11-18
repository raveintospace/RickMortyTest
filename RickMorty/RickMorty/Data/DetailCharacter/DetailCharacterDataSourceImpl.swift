//
//  DetailCharacterDataSourceImpl.swift
//  RickMorty
//
//  Created by Uri on 15/11/25.
//

import Foundation

actor DetailCharacterDataSourceImpl: DetailCharacterDataSourceProtocol {
    
    nonisolated private let dataService: DataServiceProtocol
    
    init(dataService: DataServiceProtocol) {
        self.dataService = dataService
    }
    
    func getDetailCharacter(id: Int) async throws -> DetailCharacter {
        
        let baseURL = APIConstants.baseURL
        
        guard var urlComponents = URLComponents(string: baseURL) else {
            throw RemoteDataSourceError.invalidURL
        }
        
        urlComponents.path += "\(APIConstants.charactersEndpoint)/\(id)"
        
        guard let finalURL = urlComponents.url else {
            throw RemoteDataSourceError.invalidURL
        }
        
        let response = try await dataService.fetch(type: DetailCharacter.self, url: finalURL)
        
        return response
    }
}
