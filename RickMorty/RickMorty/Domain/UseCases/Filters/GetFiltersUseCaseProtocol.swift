//
//  GetFiltersUseCaseProtocol.swift
//  RickMorty
//
//  Created by Uri on 14/11/25.
//

protocol GetFiltersUseCaseProtocol {
    func executeGenderFilters() async throws -> [Filter]
    func executeStatusFilters() async throws -> [Filter]
}
