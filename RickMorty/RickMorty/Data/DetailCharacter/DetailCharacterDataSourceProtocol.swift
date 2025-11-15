//
//  DetailCharacterDataSourceProtocol.swift
//  RickMorty
//
//  Created by Uri on 15/11/25.
//

protocol DetailCharacterDataSourceProtocol {
    func getDetailCharacter(id: Int) async throws -> DetailCharacter
}
