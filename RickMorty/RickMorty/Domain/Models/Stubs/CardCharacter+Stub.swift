//
//  CardCharacter+Stub.swift
//  RickMorty
//
//  Created by Uri on 13/11/25.
//

import Foundation

#if DEBUG
extension CardCharacter {
    
    private static func generateImageURL(id: Int) -> URL {
        return URL(string: "https://rickandmortyapi.com/api/character/avatar/\(id).jpeg")!
    }
    
    nonisolated enum Stub {
        static let stub1 = CardCharacter(
            id: 1,
            name: "Rick Sanchez",
            status: .alive,
            gender: .male,
            species: "Human",
            type: "",
            image: generateImageURL(id: 1)
        )
        
        static let stub2 = CardCharacter(
            id: 2,
            name: "Morty Smith",
            status: .alive,
            gender: .male,
            species: "Human",
            type: "",
            image: generateImageURL(id: 2)
        )
        
        static let stub6 = CardCharacter(
            id: 6,
            name: "Abadango Cluster Princess",
            status: .alive,
            gender: .female,
            species: "Alien",
            type: "",
            image: generateImageURL(id: 6)
        )
        
        static let stub8 = CardCharacter(
            id: 8,
            name: "Adjudicator Rick",
            status: .dead,
            gender: .male,
            species: "Human",
            type: "",
            image: generateImageURL(id: 8)
        )
    }
}
#endif
