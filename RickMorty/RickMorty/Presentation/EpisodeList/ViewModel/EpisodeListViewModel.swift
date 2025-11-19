//
//  EpisodeListViewModel.swift
//  RickMorty
//
//  Created by Uri on 17/11/25.
//

import Foundation

@Observable
final class EpisodeListViewModel {

    private(set) var fetchedEpisodes: [Episode] = []
    private(set) var totalEpisodesCount: Int = 0

    var fetchedEpisodesCount: Int {
        fetchedEpisodes.count
    }

    // MARK: - Fetch properties
    private(set) var isLoading: Bool = false
    private(set) var canFetchMore: Bool = true
    private(set) var currentPage: Int = 1
    private(set) var errorMessage: String?

    // MARK: - Dependency injection
    private let fetchEpisodesUseCase: FetchEpisodesUseCaseProtocol

    init(fetchEpisodesUseCase: FetchEpisodesUseCaseProtocol) {
        self.fetchEpisodesUseCase = fetchEpisodesUseCase
    }

    // MARK: - Fetch episodes
    @MainActor
    func loadEpisodes() async {
        guard !isLoading && canFetchMore else { return }

        self.isLoading = true
        self.errorMessage = nil // Clean previous errors

        defer { isLoading = false }

        do {
            let response = try await fetchEpisodesUseCase.execute(page: currentPage)

            self.fetchedEpisodes.append(contentsOf: response.results)

            self.totalEpisodesCount = response.info.objectCount

            // Update properties for the next fetch
            self.canFetchMore = response.info.nextPage != nil
            self.currentPage += 1
        } catch {
            if let remoteError = error as? RemoteDataSourceError {
                switch remoteError {
                case .invalidURL, .badServerResponse:
                    self.errorMessage = "Network Error: We couldn't reach the server."
                case .decodingError:
                    self.errorMessage = "Data Error: The received episode data is corrupt."
                case .httpError(let statusCode):
                    self.errorMessage = "Server Error: Received status code \(statusCode)."
                }
            } else {
                self.errorMessage = "An unexpected error occurred: \(error.localizedDescription)"
            }

            self.canFetchMore = false
        }
    }
}
