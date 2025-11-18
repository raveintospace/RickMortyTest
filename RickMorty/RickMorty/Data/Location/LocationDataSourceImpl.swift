//
//  LocationDataSourceImpl.swift
//  RickMorty
//
//  Created by Uri on 16/11/25.
//

import Foundation

actor LocationDataSourceImpl: LocationDataSourceProtocol {
    
    nonisolated private let dataService: DataServiceProtocol
    
    init(dataService: DataServiceProtocol) {
        self.dataService = dataService
    }
    
    func getLocation(url: URL) async throws -> DetailLocation {
        
        // Check that the received URL matches our baseURL
        guard url.absoluteString.starts(with: APIConstants.baseURL) else {
            throw RemoteDataSourceError.invalidURL
        }
        
        let response = try await dataService.fetch(type: DetailLocation.self, url: url)
        
        return response
    }
}
