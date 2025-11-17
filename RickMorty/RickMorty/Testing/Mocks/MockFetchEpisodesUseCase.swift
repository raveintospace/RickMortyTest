//
//  MockFetchEpisodesUseCase.swift
//  RickMorty
//
//  Created by Uri on 17/11/25.
//

import Foundation

final class MockFetchEpisodesUseCase: FetchEpisodesUseCaseProtocol {
    
    var shouldFail: Bool = false
    var mockResponse: EpisodePageResponse?
    
    // Check the page requested by viewmodel
    private(set) var lastRequestedPage: Int?
    
    func execute(page: Int) async throws -> EpisodePageResponse {
        
        self.lastRequestedPage = page
        
        if shouldFail {
            throw NSError(domain: "MockError",
                          code: 404,
                          userInfo: [NSLocalizedDescriptionKey: "Mocked episode fetch failure"])
        }
        
        guard let response = mockResponse else {
            fatalError("MockResponse was nil")
        }
        
        return response
    }
}
