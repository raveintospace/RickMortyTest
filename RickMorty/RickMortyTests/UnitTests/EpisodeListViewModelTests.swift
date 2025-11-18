//
//  EpisodeListViewModelTests.swift
//  RickMorty
//
//  Created by Uri on 18/11/25.
//

import Foundation
import Testing
@testable import RickMorty

// Specific test stubs to avoid being strictly attached to preview stubs
extension Episode {
    nonisolated enum TestStub {
        static let stub1 = Episode.Stub.stub1
        static let stub2 = Episode.Stub.stub2
    }
}

extension PageInfo {
    nonisolated enum TestStub {
        static let initialInfo = PageInfo.Stub.stubEpisodePage1
        static let finalInfo = PageInfo.Stub.stubEpisodePage3
    }
}

extension EpisodePageResponse {
    nonisolated enum TestStub {
        static let initialResponse = EpisodePageResponse(info: PageInfo.TestStub.initialInfo,
                                                         results: [Episode.TestStub.stub1])
        
        static let finalResponse = EpisodePageResponse(info: PageInfo.TestStub.finalInfo,
                                                       results: [Episode.TestStub.stub2])
    }
}


// MainActor is required because app's method uses it
@MainActor
struct EpisodeListViewModelTests {
    
    @Test func testLoadEpisodes_success_initialLoad() async throws {
        
        // Given
        let expectedResponse = EpisodePageResponse.TestStub.initialResponse
        let useCase = MockFetchEpisodesUseCase(result: .success(expectedResponse))
        let sut = EpisodeListViewModel(fetchEpisodesUseCase: useCase)
        
        // When
        await sut.loadEpisodes()
        
        // Then
        #expect(sut.isLoading == false)
        #expect(sut.errorMessage == nil)
        
        #expect(sut.fetchedEpisodesCount == 1)
        #expect(sut.totalEpisodesCount == PageInfo.Stub.stubEpisodePage1.objectCount)
        #expect(sut.canFetchMore == true)
        #expect(sut.currentPage == 2)
        
        #expect(sut.fetchedEpisodes.first?.id == 1)
        #expect(useCase.lastRequestedPage == 1)
    }

}

