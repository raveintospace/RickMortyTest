//
//  FiltersRepositoryImpl.swift
//  RickMorty
//
//  Created by Uri on 14/11/25.
//

import Foundation

struct FiltersRepositoryImpl: FiltersRepositoryProtocol {
    func getGenderFilters() async throws -> [Filter] {
        return [
            Filter(title: "Female"),
            Filter(title: "Genderless"),
            Filter(title: "Male"),
            Filter(title: "Unknown")
        ]
    }

    func getStatusFilters() async throws -> [Filter] {
        return [
            Filter(title: "Alive"),
            Filter(title: "Dead"),
            Filter(title: "Unknown")
        ]
    }
}
