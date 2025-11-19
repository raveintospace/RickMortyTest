//
//  MockDataService.swift
//  RickMorty
//
//  Created by Uri on 18/11/25.
//

import Foundation
@testable import RickMorty

final class MockDataService: DataServiceProtocol {

    enum MockedResult {
        case success(Data)
        case failure(RemoteDataSourceError)
    }

    let result: MockedResult
    let expectedURL: URL

    init(result: MockedResult, expectedURL: URL) {
        self.result = result
        self.expectedURL = expectedURL
    }

    func fetch<T: Decodable & Sendable>(type: T.Type = T.self, url: URL?) async throws -> T {
        switch result {
        case .success(let data):
            guard url == expectedURL else {
                throw RemoteDataSourceError.invalidURL
            }

            do {
                let decodedObject = try JSONDecoder().decode(T.self, from: data)
                return decodedObject
            } catch {
                throw RemoteDataSourceError.decodingError(error)
            }

        case .failure(let error):
            throw error
        }
    }
}
