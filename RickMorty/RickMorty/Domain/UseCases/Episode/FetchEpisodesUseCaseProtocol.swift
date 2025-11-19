//
//  FetchEpisodesUseCaseProtocol.swift
//  RickMorty
//
//  Created by Uri on 17/11/25.
//

/// Defines the contract for fetching a list of episodes for the Episode List view
protocol FetchEpisodesUseCaseProtocol {

    /// Retrieves a single page of episode data from the API
    func execute(page: Int) async throws -> EpisodePageResponse
}
