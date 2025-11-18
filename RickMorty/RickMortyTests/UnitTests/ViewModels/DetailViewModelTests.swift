//
//  DetailViewModelTests.swift
//  RickMorty
//
//  Created by Uri on 18/11/25.
//

import Foundation
import Testing
@testable import RickMorty

extension DetailCharacter {
    nonisolated enum TestStub {
        static let stub1 = DetailCharacter.Stub.stub1
        static let stub10 = DetailCharacter.Stub.stub10
        static let stub50 = DetailCharacter.Stub.stub50
    }
}

@MainActor
struct DetailViewModelTests {
    
    private let testID = 1
    
    @Test func testLoadCharacter_success() async throws {
        
        // Given
        let expectedDetailCharacter = DetailCharacter.TestStub.stub1
        let useCase = MockFetchDetailCharacterUseCase(result: .success(expectedDetailCharacter))
        let sut = DetailViewModel(characterID: testID, fetchDetailCharacterUseCase: useCase)
        
        // When
        await sut.loadCharacter()
        
        // Then
        #expect(sut.isLoading == false)
        #expect(sut.errorMessage == nil)
        #expect(sut.character != nil)
        #expect(sut.character == expectedDetailCharacter)
        #expect(sut.character?.name == expectedDetailCharacter.name)
        #expect(useCase.requestedId == testID)
    }
    
    @Test func testLoadCharacter_allErrorCases() async throws {
        
        let errorCases: [(RemoteDataSourceError, String)] = [
            (.invalidURL, "Network Error: We couldn't reach the server."),
            (.badServerResponse, "Network Error: We couldn't reach the server."),
            (.decodingError(NSError(domain: "Test", code: 0)), "Data Error: The received character data is corrupt."),
            (.httpError(statusCode: 500), "Server Error: Received status code 500.")
        ]
        
        for (error, expectedMessage) in errorCases {
            
            // Given
            let useCase = MockFetchDetailCharacterUseCase(result: .failure(error))
            let sut = DetailViewModel(characterID: testID, fetchDetailCharacterUseCase: useCase)
            
            // When
            await sut.loadCharacter()
            
            // Then
            #expect(sut.isLoading == false)
            #expect(sut.errorMessage == expectedMessage)
            #expect(sut.character == nil)
            #expect(useCase.requestedId == testID)
        }
    }
    
    @Test func testEpisodeCountText_returnsCorrectString() {
        
        // Given
        let noEpisodesCharacter = DetailCharacter(
            id: 999,
            name: "Empty",
            status: .unknown,
            gender: .unknown,
            species: "Alien",
            type: "N/A",
            image: nil,
            episode: [],
            origin: nil,
            location: nil
        )
        let oneEpisodeCharacter = DetailCharacter.TestStub.stub10
        let multipleEpisodesCharacter = DetailCharacter.TestStub.stub1
        
        // Then
        #expect(noEpisodesCharacter.episodeCountText == "· Appears on no episodes ·")
        #expect(oneEpisodeCharacter.episodeCountText == "· Appears on 1 episode ·")
        #expect(multipleEpisodesCharacter.episodeCountText == "· Appears on \(multipleEpisodesCharacter.episodeCount) episodes ·")
    }
    
    @Test func testLoadCharacter_deferSetsIsLoadingToFalse() async throws {
        
        // Given
        let expectedError = RemoteDataSourceError.badServerResponse
        let useCase = MockFetchDetailCharacterUseCase(result: .failure(expectedError))
        let sut = DetailViewModel(characterID: testID, fetchDetailCharacterUseCase: useCase)
        
        // When
        await sut.loadCharacter()
        
        // Then
        #expect(sut.isLoading == false)
        #expect(sut.character == nil)
        #expect(sut.errorMessage == "Network Error: We couldn't reach the server.")
    }
}
