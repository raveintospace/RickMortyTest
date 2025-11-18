//
//  MockFetchEpisodesUseCase.swift
//  RickMorty
//
//  Created by Uri on 17/11/25.
//

import Foundation
@testable import RickMorty

final class MockFetchEpisodesUseCase: FetchEpisodesUseCaseProtocol {
    
    enum MockedEpisodeResult {
        case success(EpisodePageResponse)
        case failure(RemoteDataSourceError)
    }
    
    var result: MockedEpisodeResult
    
    // Check the page requested by viewmodel
    private(set) var lastRequestedPage: Int?
    
    init(result: MockedEpisodeResult) {
        self.result = result
    }
    
    func execute(page: Int) async throws -> EpisodePageResponse {
        
        self.lastRequestedPage = page
        
        switch result {
        case .success(let response):
            return response
        case .failure(let error):
            throw error
        }
    }
}
