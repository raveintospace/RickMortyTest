//
//  APIConstants.swift
//  RickMorty
//
//  Created by Uri on 13/11/25.
//

nonisolated struct APIConstants {

    static let baseURL = "https://rickandmortyapi.com/api/"

    static let charactersEndpoint = "character"

    static let charactersListURL = baseURL + charactersEndpoint

    static let episodesEndpoint = "episode"

    static let episodesListURL = baseURL + episodesEndpoint
}
