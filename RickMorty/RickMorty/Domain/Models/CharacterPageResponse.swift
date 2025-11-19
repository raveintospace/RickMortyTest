//
//  CharacterPageResponse.swift
//  RickMorty
//
//  Created by Uri on 13/11/25.
//

import Foundation

nonisolated struct CharacterPageResponse: Decodable, Sendable {
    let info: PageInfo
    let results: [CardCharacter]
}
