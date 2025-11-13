//
//  CharacterPageResponse.swift
//  RickMorty
//
//  Created by Uri on 13/11/25.
//

import Foundation

struct CharacterPageResponse: Decodable {
    
    let info: PageInfo
    let results: [CardCharacter]
}
