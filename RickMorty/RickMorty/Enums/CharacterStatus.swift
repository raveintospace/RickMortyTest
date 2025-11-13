//
//  CharacterStatus.swift
//  RickMorty
//
//  Created by Uri on 13/11/25.
//

/// Status of the characters
enum CharacterStatus: String, Decodable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "Unknown"
}
