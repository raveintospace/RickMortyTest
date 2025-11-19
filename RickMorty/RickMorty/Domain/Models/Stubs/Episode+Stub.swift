//
//  Episode+Stub.swift
//  RickMorty
//
//  Created by Uri on 17/11/25.
//

import Foundation

#if DEBUG
extension Episode {

    nonisolated enum Stub {
        static let stub1 = Episode(
            id: 1,
            name: "Pilot",
            airDate: "December 2, 2013",
            episodeCode: "S01E01",
            characters: [
                "https://rickandmortyapi.com/api/character/1",
                "https://rickandmortyapi.com/api/character/2",
                "https://rickandmortyapi.com/api/character/35",
                "https://rickandmortyapi.com/api/character/38",
                "https://rickandmortyapi.com/api/character/62",
                "https://rickandmortyapi.com/api/character/92",
                "https://rickandmortyapi.com/api/character/127",
                "https://rickandmortyapi.com/api/character/144",
                "https://rickandmortyapi.com/api/character/158",
                "https://rickandmortyapi.com/api/character/175",
                "https://rickandmortyapi.com/api/character/179",
                "https://rickandmortyapi.com/api/character/181",
                "https://rickandmortyapi.com/api/character/239",
                "https://rickandmortyapi.com/api/character/249",
                "https://rickandmortyapi.com/api/character/271",
                "https://rickandmortyapi.com/api/character/338",
                "https://rickandmortyapi.com/api/character/394",
                "https://rickandmortyapi.com/api/character/395",
                "https://rickandmortyapi.com/api/character/435"
            ]
        )

        static let stub2 = Episode(
            id: 2,
            name: "Lawnmower Dog",
            airDate: "December 9, 2013",
            episodeCode: "S01E02",
            characters: [
                "https://rickandmortyapi.com/api/character/1",
                "https://rickandmortyapi.com/api/character/2",
                "https://rickandmortyapi.com/api/character/38",
                "https://rickandmortyapi.com/api/character/46",
                "https://rickandmortyapi.com/api/character/63",
                "https://rickandmortyapi.com/api/character/80",
                "https://rickandmortyapi.com/api/character/175",
                "https://rickandmortyapi.com/api/character/221",
                "https://rickandmortyapi.com/api/character/239",
                "https://rickandmortyapi.com/api/character/246",
                "https://rickandmortyapi.com/api/character/304",
                "https://rickandmortyapi.com/api/character/305",
                "https://rickandmortyapi.com/api/character/306",
                "https://rickandmortyapi.com/api/character/329",
                "https://rickandmortyapi.com/api/character/338",
                "https://rickandmortyapi.com/api/character/396",
                "https://rickandmortyapi.com/api/character/397",
                "https://rickandmortyapi.com/api/character/398",
                "https://rickandmortyapi.com/api/character/405"
            ]
        )

        static let stub5 = Episode(
            id: 5,
            name: "Meeseeks and Destroy",
            airDate: "January 20, 2014",
            episodeCode: "S01E05",
            characters: [
                "https://rickandmortyapi.com/api/character/1",
                "https://rickandmortyapi.com/api/character/2",
                "https://rickandmortyapi.com/api/character/38",
                "https://rickandmortyapi.com/api/character/41",
                "https://rickandmortyapi.com/api/character/89",
                "https://rickandmortyapi.com/api/character/116",
                "https://rickandmortyapi.com/api/character/117",
                "https://rickandmortyapi.com/api/character/120",
                "https://rickandmortyapi.com/api/character/175",
                "https://rickandmortyapi.com/api/character/193",
                "https://rickandmortyapi.com/api/character/238",
                "https://rickandmortyapi.com/api/character/242",
                "https://rickandmortyapi.com/api/character/271",
                "https://rickandmortyapi.com/api/character/303",
                "https://rickandmortyapi.com/api/character/326",
                "https://rickandmortyapi.com/api/character/333",
                "https://rickandmortyapi.com/api/character/338",
                "https://rickandmortyapi.com/api/character/343",
                "https://rickandmortyapi.com/api/character/399",
                "https://rickandmortyapi.com/api/character/400"
            ]
        )
    }
}
#endif
