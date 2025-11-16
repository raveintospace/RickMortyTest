//
//  MockFetchLocationUseCase.swift
//  RickMorty
//
//  Created by Uri on 16/11/25.
//

import Foundation

final class MockFetchLocationUseCase: FetchLocationUseCaseProtocol {
    
    var shouldFail: Bool = false
    var mockResponse: DetailLocation?
    
    // Check the url requested by viewmodel
    private(set) var requestedURL: URL?
    
    func execute(url: URL) async throws -> DetailLocation {
        
        self.requestedURL = url
        
        if shouldFail {
            throw NSError(domain: "MockError",
                          code: 404,
                          userInfo: [NSLocalizedDescriptionKey: "Mocked detail location fetch failure"])
        }
        
        guard let response = mockResponse else {
            fatalError("MockResponse was nil")
        }
        
        return response
    }
}
