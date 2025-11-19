//
//  DetailViewModel.swift
//  RickMorty
//
//  Created by Uri on 15/11/25.
//

import Foundation

@Observable
final class DetailViewModel {

    private(set) var character: DetailCharacter?
    private(set) var isLoading: Bool = false
    private(set) var errorMessage: String?

    private let characterID: Int

    // MARK: - Dependency injection
    private let fetchDetailCharacterUseCase: FetchDetailCharacterUseCaseProtocol

    init(characterID: Int,
         fetchDetailCharacterUseCase: FetchDetailCharacterUseCaseProtocol
    ) {
        self.characterID = characterID
        self.fetchDetailCharacterUseCase = fetchDetailCharacterUseCase
    }

    @MainActor
    func loadCharacter() async {
        guard !isLoading else { return }

        isLoading = true
        errorMessage = nil

        defer { isLoading = false }

        do {
            let fetchedCharacter = try await fetchDetailCharacterUseCase.execute(id: characterID)

            self.character = fetchedCharacter
        } catch {
            if let remoteError = error as? RemoteDataSourceError {
                switch remoteError {
                case .invalidURL, .badServerResponse:
                    self.errorMessage = "Network Error: We couldn't reach the server."
                case .decodingError:
                    self.errorMessage = "Data Error: The received character data is corrupt."
                case .httpError(let statusCode):
                    self.errorMessage = "Server Error: Received status code \(statusCode)."
                }
            } else {
                self.errorMessage = "An unexpected error occurred: \(error.localizedDescription)"
            }
        }
    }
}
