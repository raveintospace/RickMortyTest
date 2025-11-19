//
//  FetchEpisodesUseCaseImpl.swift
//  RickMorty
//
//  Created by Uri on 17/11/25.
//

import Foundation

struct FetchEpisodesUseCaseImpl: FetchEpisodesUseCaseProtocol {

    // Dependency injection of the Data Source
    private let dataSource: EpisodeDataSourceProtocol

    init(dataSource: EpisodeDataSourceProtocol) {
        self.dataSource = dataSource
    }

    func execute(page: Int) async throws -> EpisodePageResponse {
        do {
            return try await dataSource.getEpisodes(page: page)
        } catch {
            debugPrint("Error in FetchEpisodesUseCaseImpl: \(error.localizedDescription)")
            throw error
        }
    }
}
