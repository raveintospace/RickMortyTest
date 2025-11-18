//
//  DetailCharacter+Stub.swift
//  RickMorty
//
//  Created by Uri on 15/11/25.
//

import Foundation

#if DEBUG
extension DetailCharacter {
    
    private static func generateImageURL(id: Int) -> URL {
        return URL(string: "https://rickandmortyapi.com/api/character/avatar/\(id).jpeg")!
    }
    
    nonisolated enum Stub {
        static let stub1 = DetailCharacter(
            id: 1,
            name: "Rick Sanchez",
            status: .alive,
            gender: .male,
            species: "Human",
            type: "",
            image: generateImageURL(id: 1),
            episode: [
                "https://rickandmortyapi.com/api/episode/1",
                "https://rickandmortyapi.com/api/episode/2",
                "https://rickandmortyapi.com/api/episode/3",
                "https://rickandmortyapi.com/api/episode/4",
                "https://rickandmortyapi.com/api/episode/5",
                "https://rickandmortyapi.com/api/episode/6",
                "https://rickandmortyapi.com/api/episode/7",
                "https://rickandmortyapi.com/api/episode/8",
                "https://rickandmortyapi.com/api/episode/9",
                "https://rickandmortyapi.com/api/episode/10"
            ],
            origin: CharacterLocation(name: "Earth (C-137)",
                                      url: URL(string: "https://rickandmortyapi.com/api/location/1")!),
            location: CharacterLocation(name: "Citadel of Ricks",
                                        url: URL(string: "https://rickandmortyapi.com/api/location/3")!)
        )
        
        static let stub10 = DetailCharacter(
            id: 10,
            name: "Alan Rails",
            status: .dead,
            gender: .male,
            species: "Human",
            type: "Superhuman (Ghost trains summoner)",
            image: generateImageURL(id: 10),
            episode: ["https://rickandmortyapi.com/api/episode/25"],
            origin: CharacterLocation(name: "unknown",
                                      url: URL(string: "")),
            location: CharacterLocation(name: "Worldender's lair",
                                        url: URL(string: "https://rickandmortyapi.com/api/location/4")!)
        )
        
        static let stub50 = DetailCharacter(
            id: 50,
            name: "Blim Blam",
            status: .alive,
            gender: .male,
            species: "Alien",
            type: "Korblock",
            image: generateImageURL(id: 50),
            episode: ["https://rickandmortyapi.com/api/episode/14"],
            origin: CharacterLocation(name: "unknown",
                                      url: URL(string: "")),
            location: CharacterLocation(name: "Earth (Replacement Dimension)",
                                        url: URL(string: "https://rickandmortyapi.com/api/location/20")!)
        )
    }
}
#endif
