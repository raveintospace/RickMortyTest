//
//  CardCharacterDataSourceProtocol.swift
//  RickMorty
//
//  Created by Uri on 13/11/25.
//

protocol CardCharacterDataSourceProtocol {
    func getCardCharacters(page: Int) async throws -> CharacterPageResponse
}
