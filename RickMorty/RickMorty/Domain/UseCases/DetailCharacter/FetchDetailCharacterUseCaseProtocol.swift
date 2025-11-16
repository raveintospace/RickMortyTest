//
//  FetchDetailCharacterUseCaseProtocol.swift
//  RickMorty
//
//  Created by Uri on 15/11/25.
//

/// Defines the contract for fetching a Character for the DetailView
protocol FetchDetailCharacterUseCaseProtocol {
    
    /// Retrieves a single character from the API
    func execute(id: Int) async throws -> DetailCharacter
}
