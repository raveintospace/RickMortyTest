//
//  FetchCardCharactersUseCaseImpl.swift
//  RickMorty
//
//  Created by Uri on 13/11/25.
//

import Foundation

struct FetchCardCharactersUseCaseImpl: FetchCardCharactersUseCaseProtocol {

    // Dependency injection of the Data source
    private let dataSource: CardCharacterDataSourceProtocol

    init(dataSource: CardCharacterDataSourceProtocol) {
        self.dataSource = dataSource
    }

    func execute(page: Int) async throws -> CharacterPageResponse {
        do {
            return try await dataSource.getCardCharacters(page: page)
        } catch {
            debugPrint("Error in FetchCardCharactersUseCaseImpl: \(error.localizedDescription)")
            throw error
        }
    }
}
