//
//  DatabaseViewSnapshotTests.swift
//  RickMorty
//
//  Created by Uri on 19/11/25.
//

import SwiftUI
import SnapshotTesting
import Testing
@testable import RickMorty

@MainActor
struct DatabaseViewSnapshotTests {
    
    @Test func testDatabaseView_DefaultState() {
        let view = DatabaseView()
            .environment(\.isPad, false)
            .environment(\.databaseViewModel, DeveloperPreview.instance.databaseViewModel)
        
        assertSnapshotView(view)
    }
    
    @Test func testDatabaseView_WithCharactersLoaded() async throws {
        let response = CharacterPageResponse.Stub.stub1
        
        // Provide two responses: one for manual load, one for view's .task
        let useCase = MockFetchCardCharactersUseCase(results: [
            .success(response),
            .success(response)
        ])
        
        let viewModel = DatabaseViewModel(fetchCardCharactersUseCase: useCase,
                                          getFiltersUseCase: MockGetFiltersUseCase())
        
        // Load characters before creating the view
        await viewModel.loadCharacters()
        
        #expect(viewModel.fetchedCharacters.count == response.results.count)
        
        let view = DatabaseView()
            .environment(\.databaseViewModel, viewModel)
            .environment(\.isPad, false)
        
        try await Task.sleep(for: .milliseconds(500))
        
        assertSnapshotView(view)
        
        #expect(viewModel.displayedCharacters.count == response.results.count)
        #expect(viewModel.displayedCharacters.first?.id == response.results.first?.id)
        #expect(viewModel.displayedCharacters.last?.id == response.results.last?.id)
    }
    
    @Test func testDatabaseView_NoResultsFiltering() async throws {
        let response = CharacterPageResponse.Stub.stub1
        
        // Provide two responses: one for manual load, one for view's .task
        let useCase = MockFetchCardCharactersUseCase(results: [
            .success(response),
            .success(response)
        ])
        
        let viewModel = DatabaseViewModel(fetchCardCharactersUseCase: useCase,
                                          getFiltersUseCase: MockGetFiltersUseCase())
        
        // Load characters before creating the view
        await viewModel.loadCharacters()
        
        viewModel.selectedFilter = Filter(title: "Dead")
        
        #expect(viewModel.fetchedCharacters.count == response.results.count)
        #expect(viewModel.displayedCharacters.isEmpty)
        #expect(viewModel.showNoResultsView == true)
        
        let view = DatabaseView()
            .environment(\.isPad, false)
            .environment(\.databaseViewModel, viewModel)
        
        assertSnapshotView(view)
    }
}
