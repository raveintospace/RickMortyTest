//
//  MockCardCharacterDataSourceProtocol.swift
//  RickMorty
//
//  Created by Uri on 18/11/25.
//

import Foundation
@testable import RickMorty

final class MockCardCharacterDataSourceProtocol: CardCharacterDataSourceProtocol {

    enum MockedResult {
        case success(CharacterPageResponse)
        case failure(Error)
    }

    let result: MockedResult

    private(set) var requestedPage: Int?

    init(result: MockedResult) {
        self.result = result
    }

    func getCardCharacters(page: Int) async throws -> CharacterPageResponse {
        self.requestedPage = page

        switch result {
        case .success(let characterPageResponse):
            return characterPageResponse
        case .failure(let error):
            throw error
        }
    }
}
