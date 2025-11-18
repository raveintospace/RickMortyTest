//
//  CharacterLocation+Stub.swift
//  RickMorty
//
//  Created by Uri on 15/11/25.
//

import Foundation

#if DEBUG
extension CharacterLocation {
    
    nonisolated enum Stub {
        static let stub1 = CharacterLocation(name: "Earth",
                                             url: URL(string: "https://rickandmortyapi.com/api/location/1")!)
        
        static let stub20 = CharacterLocation(name: "Earth (Replacement Dimension)",
                                             url: URL(string: "https://rickandmortyapi.com/api/location/20")!)
        
        static let stub40 = CharacterLocation(name: "Gazorpazorp",
                                            url: URL(string: "https://rickandmortyapi.com/api/location/40")!)
    }
}
#endif
