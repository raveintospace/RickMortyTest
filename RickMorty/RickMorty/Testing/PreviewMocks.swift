//
//  PreviewMocks.swift
//  RickMorty
//
//  Created by Uri on 18/11/25.
//

import Foundation

#if DEBUG
final class MockPreviewFetchCardCharactersUseCase: FetchCardCharactersUseCaseProtocol {

    func execute(page: Int) async throws -> CharacterPageResponse {
        return CharacterPageResponse.Stub.stub1
    }
}

final class MockPreviewGetFiltersUseCase: GetFiltersUseCaseProtocol {
    func executeGenderFilters() async throws -> [Filter] {
        return Filter.Stub.gender
    }

    func executeStatusFilters() async throws -> [Filter] {
        return Filter.Stub.status
    }
}
#endif
