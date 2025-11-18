//
//  CardCharacterViewModelTests.swift
//  RickMorty
//
//  Created by Uri on 18/11/25.
//

import Foundation
import Testing
@testable import RickMorty

// Specific test stubs to avoid being strictly attached to preview stubs
extension CardCharacter {
    nonisolated enum TestStub {
        static let stub1 = CardCharacter.Stub.stub1
        static let stub2 = CardCharacter.Stub.stub2
        static let stub6 = CardCharacter.Stub.stub6
        static let stub8 = CardCharacter.Stub.stub8
    }
}

extension PageInfo {
    nonisolated enum CardCharacterTestStub {
        static let initialInfo = PageInfo.Stub.stubCharacterPage1
        static let finalInfo = PageInfo.Stub.stubCharacterPage2
    }
}

extension CharacterPageResponse {
    nonisolated enum TestStub {
        static let initialResponse = CharacterPageResponse(info: PageInfo.EpisodeTestStub.initialInfo,
                                                           results: [CardCharacter.TestStub.stub1,
                                                                     CardCharacter.TestStub.stub2])
        
        static let finalResponse = CharacterPageResponse(info: PageInfo.EpisodeTestStub.finalInfo,
                                                         results: [CardCharacter.TestStub.stub6,
                                                                   CardCharacter.TestStub.stub8])
    }
}

@MainActor
struct CardCharacterListViewModelTests {
    
    // MARK: - Load
    @Test func testLoadCharacters_success_initialLoad() async throws {
        
        // Given
        let expectedResponse = CharacterPageResponse.TestStub.initialResponse
        let useCase = MockFetchCardCharactersUseCase(results: [.success(expectedResponse)])
        let sut = DatabaseViewModel(fetchCardCharactersUseCase: useCase,
                                    getFiltersUseCase: MockGetFiltersUseCase())
        
        // When
        await sut.loadCharacters()
        
        // Then
        #expect(sut.isLoading == false)
        #expect(sut.errorMessage == nil)
        
        #expect(sut.fetchedCharactersCount == expectedResponse.results.count)
        #expect(sut.totalCharacterCount == expectedResponse.info.objectCount)
        #expect(sut.canFetchMore == true)
        #expect(sut.currentPage == 2)
        
        #expect(sut.fetchedCharacters.first?.id == expectedResponse.results.first?.id)
        #expect(useCase.requestedPages == [1])
    }

    @Test func testLoadCharacters_success_pagination() async throws {
        
        // Given
        let initialResponse = CharacterPageResponse.TestStub.initialResponse
        let finalResponse = CharacterPageResponse.TestStub.finalResponse
        let useCase = MockFetchCardCharactersUseCase(results: [.success(initialResponse), .success(finalResponse)])
        let sut = DatabaseViewModel(fetchCardCharactersUseCase: useCase,
                                    getFiltersUseCase: MockGetFiltersUseCase())
        
        // When
        await sut.loadCharacters()
        await sut.loadCharacters()
        
        // Then
        #expect(sut.isLoading == false)
        #expect(sut.errorMessage == nil)
        
        #expect(sut.fetchedCharactersCount == initialResponse.results.count + finalResponse.results.count)
        #expect(sut.totalCharacterCount == finalResponse.info.objectCount)
        #expect(sut.canFetchMore == false)
        #expect(sut.currentPage == 3)
        
        #expect(sut.fetchedCharacters.first?.id == initialResponse.results.first?.id)
        #expect(sut.fetchedCharacters[2].id == finalResponse.results.first?.id)
        #expect(useCase.requestedPages == [1, 2])
    }
    
    @Test func testLoadCharacters_success_lastPage() async throws {
        
        // Given
        let finalResponse = CharacterPageResponse.TestStub.finalResponse
        let useCase = MockFetchCardCharactersUseCase(results: [.success(finalResponse)])
        let sut = DatabaseViewModel(fetchCardCharactersUseCase: useCase,
                                    getFiltersUseCase: MockGetFiltersUseCase())
        
        // When
        await sut.loadCharacters()
        
        // Then
        #expect(sut.isLoading == false)
        #expect(sut.errorMessage == nil)
        
        #expect(sut.fetchedCharactersCount == finalResponse.results.count)
        #expect(sut.totalCharacterCount == finalResponse.info.objectCount)
        #expect(sut.canFetchMore == false)
        #expect(sut.currentPage == 2)
        
        #expect(sut.fetchedCharacters.first?.id == finalResponse.results.first?.id)
        #expect(useCase.requestedPages == [1])
    }
    
    @Test func testLoadCharacters_failure_allErrorCases() async throws {
        
        let errorCases: [(RemoteDataSourceError, String)] = [
            (.invalidURL, "Network Error: We couldn't reach the server."),
            (.badServerResponse, "Network Error: We couldn't reach the server."),
            (.decodingError(NSError(domain: "Test", code: 0)), "Data Error: The received episode data is corrupt."),
            (.httpError(statusCode: 500), "Server Error: Received status code 500.")
        ]
        
        for (error, expectedMessage) in errorCases {
            
            // Given
            let useCase = MockFetchCardCharactersUseCase(results: [.failure(error)])
            let sut = DatabaseViewModel(fetchCardCharactersUseCase: useCase,
                                        getFiltersUseCase: MockGetFiltersUseCase())
            
            // When
            await sut.loadCharacters()
            
            // Then
            #expect(sut.isLoading == false)
            #expect(sut.errorMessage == expectedMessage)
            #expect(sut.currentPage == 1)
            #expect(sut.canFetchMore == false)
            #expect(sut.fetchedCharactersCount == 0)
            #expect(useCase.requestedPages == [1])
        }
    }
    
    @Test func testLoadCharacters_currentPageDoesNotIncrement_onError() async throws {
        
        // Given
        let initialPage = 1
        let useCase = MockFetchCardCharactersUseCase(results: [.failure(.invalidURL)])
        let sut = DatabaseViewModel(fetchCardCharactersUseCase: useCase,
                                    getFiltersUseCase: MockGetFiltersUseCase())
        
        let previousFetchedCount = sut.fetchedCharactersCount
        let previousCurrentPage = sut.currentPage
        
        // When
        await sut.loadCharacters()
        
        // Then
        #expect(sut.isLoading == false)
        #expect(sut.errorMessage == "Network Error: We couldn't reach the server.")
        
        #expect(sut.fetchedCharactersCount == previousFetchedCount)
        #expect(sut.currentPage == previousCurrentPage)
        #expect(sut.canFetchMore == false)
        
        #expect(useCase.requestedPages == [initialPage])
    }
    
    @Test func testFetchedCharactersCount_computesCorrectly() async throws {
        
        // Given
        let initialResponse = CharacterPageResponse.TestStub.initialResponse
        let finalResponse = CharacterPageResponse.TestStub.finalResponse
        let useCase = MockFetchCardCharactersUseCase(results: [.success(initialResponse), .success(finalResponse)])
        let sut = DatabaseViewModel(fetchCardCharactersUseCase: useCase,
                                    getFiltersUseCase: MockGetFiltersUseCase())
        
        // When
        await sut.loadCharacters()
        await sut.loadCharacters()
        
        // Then
        #expect(sut.fetchedCharactersCount == initialResponse.results.count + finalResponse.results.count)
    }
    
    @Test func testTotalCharacterCount_getsPageInfoObjectCountCorrectly() async throws {
        
        // Given
        let initialResponse = CharacterPageResponse.TestStub.initialResponse
        let useCase = MockFetchCardCharactersUseCase(results: [.success(initialResponse)])
        let sut = DatabaseViewModel(fetchCardCharactersUseCase: useCase,
                                    getFiltersUseCase: MockGetFiltersUseCase())
        
        // When
        await sut.loadCharacters()
        
        // Then
        #expect(sut.totalCharacterCount == initialResponse.info.objectCount)
    }
    
    @Test func testLoadCharacters_deferSetsIsLoadingToFalse() async throws {
        
        // Given
        let expectedError = RemoteDataSourceError.badServerResponse
        let useCase = MockFetchCardCharactersUseCase(results: [.failure(expectedError)])
        let sut = DatabaseViewModel(fetchCardCharactersUseCase: useCase,
                                    getFiltersUseCase: MockGetFiltersUseCase())
        
        // When
        await sut.loadCharacters()
        
        // Then
        #expect(sut.isLoading == false)
        #expect(sut.canFetchMore == false)
        #expect(sut.errorMessage == "Network Error: We couldn't reach the server.")
        #expect(sut.currentPage == 1)
        #expect(sut.fetchedCharactersCount == 0)
        #expect(useCase.requestedPages == [1])
    }
    
    // MARK: - Filter
    @Test func testDisplayedCharacters_appliesGenderFilterCorrectly() async throws {
        
        // Given
        let useCase = MockFetchCardCharactersUseCase(results: [.success(CharacterPageResponse.TestStub.initialResponse)])
        let sut = DatabaseViewModel(fetchCardCharactersUseCase: useCase,
                                    getFiltersUseCase: MockGetFiltersUseCase())
        
        await sut.loadCharacters()
        
        sut.selectedFilterOption = .gender
        sut.selectedFilter = Filter(title: "Male")
        
        // When
        let displayed = sut.displayedCharacters
        
        // Then
        #expect(displayed.allSatisfy { $0.gender == .male })
        #expect(displayed.count > 0)
    }
    
    // MARK: - Search
    @Test func testDisplayedCharacters_filtersBySearchText() async throws {
        // Given
        let useCase = MockFetchCardCharactersUseCase(results: [.success(CharacterPageResponse.TestStub.initialResponse)])
        let sut = DatabaseViewModel(fetchCardCharactersUseCase: useCase,
                                    getFiltersUseCase: MockGetFiltersUseCase())
        
        await sut.loadCharacters()
        
        sut.searchText = "Rick"
        
        // When
        try await Task.sleep(for: .milliseconds(350)) // Wait for debounce
        let displayed = sut.displayedCharacters
        
        // Then
        #expect(displayed.allSatisfy { $0.name.contains("Rick") })
        #expect(displayed.count > 0)
    }
    
    // MARK: - Filter & Search
    @Test func testDisplayedCharacters_filterAndSearch_combined() async throws {
        
        // Given
        let response = CharacterPageResponse(info: PageInfo.CardCharacterTestStub.initialInfo,
                                             results: [
                                                CardCharacter.TestStub.stub1, // Rick Sanchez, Alive
                                                CardCharacter.TestStub.stub2, // Morty Smith, Alive
                                                CardCharacter.TestStub.stub8  // Adjudicator Rick, Dead
                                             ])
        
        let useCase = MockFetchCardCharactersUseCase(results: [.success(response)])
        let sut = DatabaseViewModel(fetchCardCharactersUseCase: useCase,
                                    getFiltersUseCase: MockGetFiltersUseCase())
        
        sut.selectedFilterOption = .status
        sut.selectedFilter = Filter(title: "Alive")
        sut.searchText = "Rick"
        
        // When
        await sut.loadCharacters()
        
        // Then:
        #expect(sut.displayedCharacters.count == 1)
        #expect(sut.displayedCharacters.first?.name == "Rick Sanchez")
    }
    
    // MARK: - Sort
    @Test func testDisplayedCharacters_sortsByNameReversed() async throws {
        // Given
        let useCase = MockFetchCardCharactersUseCase(results: [.success(CharacterPageResponse.TestStub.initialResponse)])
        let sut = DatabaseViewModel(fetchCardCharactersUseCase: useCase,
                                    getFiltersUseCase: MockGetFiltersUseCase())
        
        await sut.loadCharacters()
        
        sut.sortOption = .nameReversed
        
        // When
        let displayed = sut.displayedCharacters
        
        // Then
        let names = displayed.map { $0.name }
        #expect(names == names.sorted(by: >))
    }
}
