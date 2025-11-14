//
//  FiltersRepositoryProtocol.swift
//  RickMorty
//
//  Created by Uri on 14/11/25.
//

protocol FiltersRepositoryProtocol {
    func getGenderFilters() async throws -> [Filter]
    func getStatusFilters() async throws -> [Filter]
}
