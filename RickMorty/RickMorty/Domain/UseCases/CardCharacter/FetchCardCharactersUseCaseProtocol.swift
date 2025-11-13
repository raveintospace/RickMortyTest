//
//  FetchCardCharactersUseCaseProtocol.swift
//  RickMorty
//
//  Created by Uri on 13/11/25.
//

/// Defines the contract for fetching a list of characters for the Database view
protocol FetchCardCharactersUseCaseProtocol {
    
    /// Retrieves a single page of character data from the API
    func execute(page: Int) async throws -> CharacterPageResponse    
}
