//
//  MockFetchDetailCharacterUseCase.swift
//  RickMorty
//
//  Created by Uri on 15/11/25.
//

import Foundation

#if DEBUG
final class MockFetchDetailCharacterUseCase: FetchDetailCharacterUseCaseProtocol {
    
    enum MockedDetailCharacterResult {
        case success(DetailCharacter)
        case failure(RemoteDataSourceError)
    }
    
    var result: MockedDetailCharacterResult
    
    // Check the id requested by viewmodel
    private(set) var requestedId: Int?
    
    init(result: MockedDetailCharacterResult) {
        self.result = result
    }
    
    func execute(id: Int) async throws -> DetailCharacter {
        
        self.requestedId = id
        
        switch result {
        case .success(let response):
            return response
        case .failure(let error):
            throw error
        }
    }
}
#endif
