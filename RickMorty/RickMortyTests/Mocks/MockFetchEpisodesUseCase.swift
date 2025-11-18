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
    
    private let results: [MockedEpisodeResult]
    private(set) var requestedPages: [Int] = []
    
    private var callIndex = 0
    
    init(results: [MockedEpisodeResult]) {
        self.results = results
    }
    
    func execute(page: Int) async throws -> EpisodePageResponse {
        requestedPages.append(page)
        
        guard callIndex < results.count else {
            fatalError("MockFetchEpisodesUseCase called more times than expected")
        }
        
        let result = results[callIndex]
        callIndex += 1
        
        switch result {
        case .success(let response):
            return response
        case .failure(let error):
            throw error
        }
    }
}
