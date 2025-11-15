//
//  MockFetchDetailCharacterUseCase.swift
//  RickMorty
//
//  Created by Uri on 15/11/25.
//

import Foundation

final class MockFetchDetailCharacterUseCase: FetchDetailCharacterUseCaseProtocol {
    
    var shouldFail: Bool = false
    var mockResponse: DetailCharacter?
    
    // Check the id requested by viewmodel
    private(set) var requestedId: Int?
    
    func execute(id: Int) async throws -> DetailCharacter {
        
        self.requestedId = id
        
        if shouldFail {
            throw NSError(domain: "MockError",
                          code: 404,
                          userInfo: [NSLocalizedDescriptionKey: "Mocked detail character fetch failure"])
        }
        
        guard let response = mockResponse else {
            fatalError("MockResponse was nil")
        }
        
        return response
    }
}
