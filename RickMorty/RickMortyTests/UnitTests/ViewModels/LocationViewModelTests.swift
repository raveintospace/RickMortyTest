//
//  LocationViewModelTests.swift
//  RickMorty
//
//  Created by Uri on 18/11/25.
//

import Foundation
import Testing
@testable import RickMorty

extension DetailLocation {
    nonisolated enum TestStub {
        static let stub1 = DetailLocation.Stub.stub1
        static let stub15 = DetailLocation.Stub.stub15
        static let stub46 = DetailLocation.Stub.stub46
    }
}

@MainActor
struct LocationViewModelTests {
    
    private let testURL = URL(string: "https://rickandmortyapi.com/api/location/1")!
    
    @Test func testLoadLocation_success() async throws {
        
        // Given
        let expectedLocation = DetailLocation.TestStub.stub1
        let useCase = MockFetchLocationUseCase(result: .success(expectedLocation))
        let sut = LocationViewModel(locationURL: testURL, fetchLocationUseCase: useCase)
        
        // When
        await sut.loadLocation()
        
        // Then
        #expect(sut.isLoading == false)
        #expect(sut.errorMessage == nil)
        #expect(sut.location != nil)
        #expect(sut.location == expectedLocation)
        #expect(sut.location?.name == expectedLocation.name)
        #expect(useCase.requestedURL == testURL)
    }
    
    @Test func testLoadLocation_allErrorCases() async throws {
        
        let errorCases: [(RemoteDataSourceError, String)] = [
            (.invalidURL, "Network Error: We couldn't reach the server."),
            (.badServerResponse, "Network Error: We couldn't reach the server."),
            (.decodingError(NSError(domain: "Test", code: 0)), "Data Error: The received location data is corrupt."),
            (.httpError(statusCode: 500), "Server Error: Received status code 500.")
        ]
        
        for (error, expectedMessage) in errorCases {
            
            // Given
            let useCase = MockFetchLocationUseCase(result: .failure(error))
            let sut = LocationViewModel(locationURL: testURL, fetchLocationUseCase: useCase)

            // When
            await sut.loadLocation()
            
            // Then
            #expect(sut.isLoading == false)
            #expect(sut.errorMessage == expectedMessage)
            #expect(sut.location == nil)
            #expect(useCase.requestedURL == testURL)
        }
    }
    
    @Test func testResidentCountText_returnsCorrectString() {
        
        // Given
        let locationNoResidents = DetailLocation(
            name: "No Res", type: "Planet", dimension: "Dim X", residents: []
        )
        let locationOneResident = DetailLocation(
            name: "One Res", type: "Planet", dimension: "Dim Y", residents: ["R1"]
        )
        let locationMultipleResidents = DetailLocation.TestStub.stub1
        
        // Then
        #expect(locationNoResidents.residentCountText == "This location has no residents.")
        #expect(locationOneResident.residentCountText == "This location has 1 resident.")
        #expect(locationMultipleResidents.residentCountText == "This location has \(locationMultipleResidents.residentCount) residents.")
    }
    
    @Test func testLoadLocation_deferSetsIsLoadingToFalse() async throws {
        
        // Given
        let expectedError = RemoteDataSourceError.badServerResponse
        let useCase = MockFetchLocationUseCase(result: .failure(expectedError))
        let sut = LocationViewModel(locationURL: testURL, fetchLocationUseCase: useCase)
        
        // When
        await sut.loadLocation()
        
        // Then
        #expect(sut.isLoading == false)
        #expect(sut.location == nil)
        #expect(sut.errorMessage == "Network Error: We couldn't reach the server.")
    }
}
