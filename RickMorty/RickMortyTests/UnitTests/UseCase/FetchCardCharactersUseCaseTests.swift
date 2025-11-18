//
//  FetchCardCharactersUseCaseTests.swift
//  RickMorty
//
//  Created by Uri on 18/11/25.
//

import Foundation
import Testing
@testable import RickMorty

// Specific test stubs to avoid being strictly attached to preview stubs
extension CardCharacter {
    nonisolated enum TestUseCaseStub {
        static let stub1 = CardCharacter.Stub.stub1
        static let stub2 = CardCharacter.Stub.stub2
        static let stub6 = CardCharacter.Stub.stub6
        static let stub8 = CardCharacter.Stub.stub8
    }
}

extension PageInfo {
    nonisolated enum CardCharacterTestUseCaseStub {
        static let initialInfo = PageInfo.Stub.stubCharacterPage1
        static let finalInfo = PageInfo.Stub.stubCharacterPage2
    }
}

extension CharacterPageResponse {
    nonisolated enum TestUseCaseStub {
        static let initialResponse = CharacterPageResponse(info: PageInfo.CardCharacterTestUseCaseStub.initialInfo,
                                                           results: [CardCharacter.TestStub.stub1,
                                                                     CardCharacter.TestStub.stub2])
        
        static let finalResponse = CharacterPageResponse(info: PageInfo.CardCharacterTestUseCaseStub.finalInfo,
                                                         results: [CardCharacter.TestStub.stub6,
                                                                   CardCharacter.TestStub.stub8])
    }
}

@MainActor
struct FetchCardCharactersUseCaseTests {
    
    @Test func testGetCardCharacters_success_propagatesDataAndCallsDataSource() async throws {
        
        // Given
        let testPage = 1
        let expectedResponse = CharacterPageResponse.TestUseCaseStub.initialResponse
        let mockDataSource = MockCardCharacterDataSourceProtocol(result: .success(expectedResponse))
        let sut = FetchCardCharactersUseCaseImpl(dataSource: mockDataSource)
        
        // When
        let actualResponse = try await sut.execute(page: testPage)
        
        // Then
        #expect(mockDataSource.requestedPage == testPage)
        #expect(actualResponse.results.count == expectedResponse.results.count)
        #expect(actualResponse.results.first?.name == expectedResponse.results.first?.name)
        #expect(actualResponse.info.objectCount == expectedResponse.info.objectCount)
    }
    
    @Test func testGetCardCharacters_failure_propagatesDataSourceError() async {
        
        // Given
        let expectedError = RemoteDataSourceError.httpError(statusCode: 500)
        let mockDataSource = MockCardCharacterDataSourceProtocol(result: .failure(expectedError))
        let sut = FetchCardCharactersUseCaseImpl(dataSource: mockDataSource)
        
        do {
            // When
            _ = try await sut.execute(page: 1)
            
            #expect(Bool(false))
        } catch let error as RemoteDataSourceError {
            #expect(error == expectedError)
        } catch {
            #expect(Bool(false))
        }
    }
}


