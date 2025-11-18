//
//  MockFetchCardCharactersUseCase.swift
//  RickMorty
//
//  Created by Uri on 13/11/25.
//

import Foundation
@testable import RickMorty

final class MockFetchCardCharactersUseCase: FetchCardCharactersUseCaseProtocol {
    
    enum MockedCardCharacterResult {
        case success(CharacterPageResponse)
        case failure(RemoteDataSourceError)
    }
    
    var result: MockedCardCharacterResult
    
    // Check the page requested by viewmodel
    private(set) var lastRequestedPage: Int?
    
    init(result: MockedCardCharacterResult) {
        self.result = result
    }
    
    func execute(page: Int) async throws -> CharacterPageResponse {
        
        self.lastRequestedPage = page
        
        switch result {
        case .success(let response):
            return response
        case .failure(let error):
            throw error
        }
    }
}
