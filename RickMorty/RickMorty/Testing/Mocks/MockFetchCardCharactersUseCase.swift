//
//  MockFetchCardCharactersUseCase.swift
//  RickMorty
//
//  Created by Uri on 13/11/25.
//

import Foundation

final class MockFetchCardCharactersUseCase: FetchCardCharactersUseCaseProtocol {
    
    var shouldFail: Bool = false
    var mockResponse: CharacterPageResponse?
    
    // Check the page requested by viewmodel
    private(set) var lastRequestedPage: Int?
    
    func execute(page: Int) async throws -> CharacterPageResponse {
        
        self.lastRequestedPage = page
        
        if shouldFail {
            throw NSError(domain: "MockError",
                          code: 404,
                          userInfo: [NSLocalizedDescriptionKey: "Mocked card character fetch failure"])
        }
        
        guard let response = mockResponse else {
            fatalError("MockResponse was nil")
        }
        
        return response
    }
}
