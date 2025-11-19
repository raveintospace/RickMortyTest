//
//  DetailLocation+Stub.swift
//  RickMorty
//
//  Created by Uri on 15/11/25.
//

import Foundation

#if DEBUG
extension DetailLocation {

    nonisolated enum Stub {
        static let stub1 = DetailLocation(
            name: "Earth (C-137)",
            type: "Planet",
            dimension: "Dimension C-137",
            residents: [
                "https://rickandmortyapi.com/api/character/38",
                    "https://rickandmortyapi.com/api/character/45",
                    "https://rickandmortyapi.com/api/character/71",
                    "https://rickandmortyapi.com/api/character/82",
                    "https://rickandmortyapi.com/api/character/83",
                    "https://rickandmortyapi.com/api/character/92",
                    "https://rickandmortyapi.com/api/character/112",
                    "https://rickandmortyapi.com/api/character/114",
                    "https://rickandmortyapi.com/api/character/116",
                    "https://rickandmortyapi.com/api/character/117",
                    "https://rickandmortyapi.com/api/character/120",
                    "https://rickandmortyapi.com/api/character/127",
                    "https://rickandmortyapi.com/api/character/155",
                    "https://rickandmortyapi.com/api/character/169"
            ]
        )

        static let stub15 = DetailLocation(
            name: "Bird World",
            type: "Planet",
            dimension: "unknown",
            residents: []
        )

        static let stub46 = DetailLocation(
            name: "Zigerion's Base",
            type: "Space station",
            dimension: "Dimension C-137",
            residents: [
                "https://rickandmortyapi.com/api/character/87",
                "https://rickandmortyapi.com/api/character/191",
                "https://rickandmortyapi.com/api/character/270",
                "https://rickandmortyapi.com/api/character/337"
              ]
        )
    }
}
#endif
