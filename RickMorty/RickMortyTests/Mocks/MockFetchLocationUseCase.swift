//
//  MockFetchLocationUseCase.swift
//  RickMorty
//
//  Created by Uri on 16/11/25.
//

import Foundation

#if DEBUG
final class MockFetchLocationUseCase: FetchLocationUseCaseProtocol {
    
    enum MockedLocationResult {
        case success(DetailLocation)
        case failure(RemoteDataSourceError)
    }
    
    var result: MockedLocationResult
    
    init(result: MockedLocationResult) {
        self.result = result
    }
    
    // Check the url requested by viewmodel
    private(set) var requestedURL: URL?
    
    func execute(url: URL) async throws -> DetailLocation {
        
        self.requestedURL = url
        
        switch result {
        case .success(let response):
            return response
        case .failure(let error):
            throw error
        }
    }
}
#endif
