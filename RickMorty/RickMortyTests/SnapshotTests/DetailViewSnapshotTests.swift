//
//  DetailViewSnapshotTests.swift
//  RickMorty
//
//  Created by Uri on 19/11/25.
//

import SwiftUI
import SnapshotTesting
import Testing
@testable import RickMorty

@MainActor
struct DetailViewSnapshotTests {

    @Test func testDetailView_LoadingState() {
        let characterID = DetailCharacter.Stub.stub1.id

        let view = DetailView(characterID: characterID)
            .environment(\.isPad, false)

        assertSnapshotView(view)
    }

    @Test func testDetailView_CharacterLoaded() async throws {
        let character = DetailCharacter.Stub.stub1
        let useCase = MockFetchDetailCharacterUseCase(result: .success(character))
        let viewModel = DetailViewModel(characterID: character.id, fetchDetailCharacterUseCase: useCase)

        await viewModel.loadCharacter()

        let view = DetailView(characterID: character.id)
            .environment(\.isPad, false)

        #expect(viewModel.character?.name == character.name)

        try await Task.sleep(for: .milliseconds(1000))

        assertSnapshotView(view)
    }

    @Test func testDetailView_ErrorState() async {
        let useCase = MockFetchDetailCharacterUseCase(result: .failure(.badServerResponse))
        let viewModel = DetailViewModel(characterID: 1, fetchDetailCharacterUseCase: useCase)

        await viewModel.loadCharacter()

        #expect(viewModel.character == nil)
        #expect(viewModel.errorMessage == "Network Error: We couldn't reach the server.")

        let view = DetailView(characterID: 1)
            .environment(\.isPad, false)

        assertSnapshotView(view)
    }

}
