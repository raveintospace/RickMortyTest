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
    
    private let results: [MockedCardCharacterResult]
    private(set) var requestedPages: [Int] = []
    
    private var callIndex = 0
    
    init(results: [MockedCardCharacterResult]) {
        self.results = results
    }
    
    func execute(page: Int) async throws -> CharacterPageResponse {
        
        requestedPages.append(page)
        
        guard callIndex < results.count else {
            fatalError("MockFetchCardCharactersUseCase called more times than expected")
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
