//
//  CardCharacter+Stub.swift
//  RickMorty
//
//  Created by Uri on 13/11/25.
//

import Foundation

#if DEBUG
extension CardCharacter {
    
    nonisolated enum Stub {
        static let stub1 = CardCharacter(
            id: 1,
            name: "Rick Sanchez",
            status: .alive,
            gender: .male,
            species: "Human",
            type: "",
            image: URL(string: "https://rickandmortyapi.com/api/character/avatar/1.jpeg")!
        )
        
        static let stub2 = CardCharacter(
            id: 2,
            name: "Morty Smith",
            status: .alive,
            gender: .male,
            species: "Human",
            type: "",
            image: URL(string: "https://rickandmortyapi.com/api/character/avatar/2.jpeg")!
        )
        
        static let stub6 = CardCharacter(
            id: 6,
            name: "Abadango Cluster Princess",
            status: .alive,
            gender: .female,
            species: "Alien",
            type: "",
            image: URL(string: "https://rickandmortyapi.com/api/character/avatar/6.jpeg")!
        )
        
        static let stub8 = CardCharacter(
            id: 8,
            name: "Adjudicator Rick",
            status: .dead,
            gender: .male,
            species: "Human",
            type: "",
            image: URL(string: "https://rickandmortyapi.com/api/character/avatar/8.jpeg")!
        )
    }
}
#endif
