//
//  GetFiltersUseCaseImpl.swift
//  RickMorty
//
//  Created by Uri on 14/11/25.
//

import Foundation

struct GetFiltersUseCaseImpl: GetFiltersUseCaseProtocol {
    private let repository: FiltersRepositoryProtocol
    
    init(repository: FiltersRepositoryProtocol) {
        self.repository = repository
    }
    
    func executeGenderFilters() async throws -> [Filter] {
        return try await repository.getGenderFilters()
    }
    
    func executeStatusFilters() async throws -> [Filter] {
        return try await repository.getStatusFilters()
    }
}
