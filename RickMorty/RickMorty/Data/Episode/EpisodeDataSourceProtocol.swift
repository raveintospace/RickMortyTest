//
//  EpisodeDataSourceProtocol.swift
//  RickMorty
//
//  Created by Uri on 17/11/25.
//

protocol EpisodeDataSourceProtocol {
    func getEpisodes(page: Int) async throws -> EpisodePageResponse
}
