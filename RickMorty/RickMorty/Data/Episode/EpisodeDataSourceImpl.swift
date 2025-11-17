//
//  EpisodeDataSourceImpl.swift
//  RickMorty
//
//  Created by Uri on 17/11/25.
//

import Foundation

actor EpisodeDataSourceImpl: EpisodeDataSourceProtocol {
    
    private let dataService: DataService
    
    init(dataService: DataService) {
        self.dataService = dataService
    }
    
    func getEpisodes(page: Int) async throws -> EpisodePageResponse {
        
        let baseURL = APIConstants.episodesListURL
        
        guard var urlComponents = URLComponents(string: baseURL) else {
            throw RemoteDataSourceError.invalidURL
        }
        
        urlComponents.queryItems =  [
            URLQueryItem(name: "page", value: "\(page)")
        ]
        
        guard let finalURL = urlComponents.url else {
            throw RemoteDataSourceError.invalidURL
        }
        
        let response = try await dataService.fetch(type: EpisodePageResponse.self, url: finalURL)
        
        return response
    }
}
