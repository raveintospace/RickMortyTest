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
    nonisolated enum EpisodeTestStub {
        static let initialInfo = PageInfo.Stub.stubEpisodePage1
        static let finalInfo = PageInfo.Stub.stubEpisodePage3
    }
}

extension EpisodePageResponse {
    nonisolated enum TestStub {
        static let initialResponse = EpisodePageResponse(info: PageInfo.EpisodeTestStub.initialInfo,
                                                         results: [Episode.TestStub.stub1])

        static let finalResponse = EpisodePageResponse(info: PageInfo.EpisodeTestStub.finalInfo,
                                                       results: [Episode.TestStub.stub2])
    }
}

// MainActor is required because app's method uses it
@MainActor
struct EpisodeListViewModelTests {

    @Test func testLoadEpisodes_success_initialLoad() async throws {

        // Given
        let expectedResponse = EpisodePageResponse.TestStub.initialResponse
        let useCase = MockFetchEpisodesUseCase(results: [.success(expectedResponse)])
        let sut = EpisodeListViewModel(fetchEpisodesUseCase: useCase)

        // When
        await sut.loadEpisodes()

        // Then
        #expect(sut.isLoading == false)
        #expect(sut.errorMessage == nil)

        #expect(sut.fetchedEpisodesCount == expectedResponse.results.count)
        #expect(sut.totalEpisodesCount == expectedResponse.info.objectCount)
        #expect(sut.canFetchMore == true)
        #expect(sut.currentPage == 2)

        #expect(sut.fetchedEpisodes.first?.id == expectedResponse.results.first?.id)
        #expect(useCase.requestedPages == [1])
    }

    @Test func testLoadEpisodes_success_pagination() async throws {

        // Given
        let initialResponse = EpisodePageResponse.TestStub.initialResponse
        let finalResponse = EpisodePageResponse.TestStub.finalResponse
        let useCase = MockFetchEpisodesUseCase(results: [.success(initialResponse), .success(finalResponse)])
        let sut = EpisodeListViewModel(fetchEpisodesUseCase: useCase)

        // When
        await sut.loadEpisodes()
        await sut.loadEpisodes()

        // Then
        #expect(sut.isLoading == false)
        #expect(sut.errorMessage == nil)

        #expect(sut.fetchedEpisodesCount == 2)
        #expect(sut.totalEpisodesCount == finalResponse.info.objectCount)
        #expect(sut.canFetchMore == false)
        #expect(sut.currentPage == 3, "Should be three, as we call load two times and the initial value is 1")

        #expect(sut.fetchedEpisodes.first?.id == initialResponse.results.first?.id)
        #expect(sut.fetchedEpisodes[1].id == finalResponse.results.first?.id)
        #expect(useCase.requestedPages == [1, 2])
    }

    @Test func testLoadEpisodes_success_lastPage() async throws {

        // Given
        let finalResponse  = EpisodePageResponse.TestStub.finalResponse
        let useCase = MockFetchEpisodesUseCase(results: [.success(finalResponse)])
        let sut = EpisodeListViewModel(fetchEpisodesUseCase: useCase)

        // When
        await sut.loadEpisodes()

        // Then
        #expect(sut.isLoading == false)
        #expect(sut.errorMessage == nil)

        #expect(sut.fetchedEpisodesCount == finalResponse.results.count)
        #expect(sut.totalEpisodesCount == finalResponse.info.objectCount)
        #expect(sut.canFetchMore == false)
        #expect(sut.currentPage == 2)

        #expect(sut.fetchedEpisodes.first?.id == finalResponse.results.first?.id)
        #expect(useCase.requestedPages == [1])
    }

    @Test func testLoadEpisodes_failure_allErrorCases() async throws {

        let errorCases: [(RemoteDataSourceError, String)] = [
            (.invalidURL, "Network Error: We couldn't reach the server."),
            (.badServerResponse, "Network Error: We couldn't reach the server."),
            (.decodingError(NSError(domain: "Test", code: 0)),
             "Data Error: The received episode data is corrupt."),
            (.httpError(statusCode: 500), "Server Error: Received status code 500.")
        ]

        for (error, expectedMessage) in errorCases {

            // Given
            let useCase = MockFetchEpisodesUseCase(results: [.failure(error)])
            let sut = EpisodeListViewModel(fetchEpisodesUseCase: useCase)

            // When
            await sut.loadEpisodes()

            // Then
            #expect(sut.isLoading == false)
            #expect(sut.errorMessage == expectedMessage)
            #expect(sut.currentPage == 1, "Current page should remain at initial value after failure")
            #expect(sut.canFetchMore == false)
            #expect(sut.fetchedEpisodesCount == 0)
            #expect(useCase.requestedPages == [1])
        }
    }

    @Test func testLoadEpisodes_currentPageDoesNotIncrement_onError() async throws {

        // Given
        let initialPage = 1
        let useCase = MockFetchEpisodesUseCase(results: [.failure(.invalidURL)])
        let sut = EpisodeListViewModel(fetchEpisodesUseCase: useCase)

        let previousFetchedCount = sut.fetchedEpisodesCount
        let previousCurrentPage = sut.currentPage

        // When
        await sut.loadEpisodes()

        // Then
        #expect(sut.isLoading == false)
        #expect(sut.errorMessage == "Network Error: We couldn't reach the server.")

        #expect(sut.fetchedEpisodesCount == previousFetchedCount)
        #expect(sut.currentPage == previousCurrentPage)
        #expect(sut.canFetchMore == false)

        #expect(useCase.requestedPages == [initialPage])
    }

    @Test func testFetchedEpisodesCount_computesCorrectly() async throws {

        // Given
        let initialResponse = EpisodePageResponse.TestStub.initialResponse
        let finalResponse = EpisodePageResponse.TestStub.finalResponse
        let useCase = MockFetchEpisodesUseCase(results: [.success(initialResponse), .success(finalResponse)])
        let sut = EpisodeListViewModel(fetchEpisodesUseCase: useCase)

        // When
        await sut.loadEpisodes()
        await sut.loadEpisodes()

        // Then
        #expect(sut.fetchedEpisodesCount == initialResponse.results.count + finalResponse.results.count, )
    }

    @Test func testTotalEpisodesCount_getsPageInfoObjectCountCorrectly() async throws {

        // Given
        let initialResponse = EpisodePageResponse.TestStub.initialResponse
        let useCase = MockFetchEpisodesUseCase(results: [.success(initialResponse)])
        let sut = EpisodeListViewModel(fetchEpisodesUseCase: useCase)

        // When
        await sut.loadEpisodes()

        // Then
        #expect(sut.totalEpisodesCount == initialResponse.info.objectCount)
    }

    @Test func testCharacterCountText_returnsCorrectString() {

        // Given
        let episodeNoCharacters = Episode(
            id: 10,
            name: "NoChars",
            airDate: "N/A",
            episodeCode: "S01E10",
            characters: []
        )
        let episodeOneCharacter = Episode(
            id: 11,
            name: "OneChar",
            airDate: "N/A",
            episodeCode: "S01E11",
            characters: ["url1"]
        )
        let episodeMultipleCharacters = Episode(
            id: 12,
            name: "ManyChars",
            airDate: "N/A",
            episodeCode: "S01E12",
            characters: [
                "url1",
                "url2",
                "url3"
            ]
        )

        // Then
        #expect(episodeNoCharacters.characterCountText == "There are no characters on this episode.")
        #expect(episodeOneCharacter.characterCountText == "There is 1 character on this episode.")
        #expect(episodeMultipleCharacters.characterCountText == "There are 3 characters on this episode.")
    }

    @Test func testLoadEpisodes_deferSetsIsLoadingToFalse() async throws {

        // Given
        let expectedError = RemoteDataSourceError.badServerResponse
        let useCase = MockFetchEpisodesUseCase(results: [.failure(expectedError)])
        let sut = EpisodeListViewModel(fetchEpisodesUseCase: useCase)

        // Assert initial state
        #expect(sut.isLoading == false)

        // When
        await sut.loadEpisodes()

        // Then
        #expect(sut.isLoading == false, "isLoading should return to false after fetch, even if there is an error")
        #expect(sut.canFetchMore == false)
        #expect(sut.errorMessage == "Network Error: We couldn't reach the server.")
        #expect(sut.currentPage == 1)
        #expect(sut.fetchedEpisodesCount == 0)
        #expect(useCase.requestedPages == [1])
    }
}
