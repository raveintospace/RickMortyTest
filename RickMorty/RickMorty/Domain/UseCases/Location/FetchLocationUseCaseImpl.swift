//
//  FetchLocationUseCaseImpl.swift
//  RickMorty
//
//  Created by Uri on 16/11/25.
//

import Foundation

struct FetchLocationUseCaseImpl: FetchLocationUseCaseProtocol {

    // Dependency injection of the DataSource
    private let dataSource: LocationDataSourceProtocol

    init(dataSource: LocationDataSourceProtocol) {
        self.dataSource = dataSource
    }

    func execute(url: URL) async throws -> DetailLocation {
        do {
            return try await dataSource.getLocation(url: url)
        } catch {
            debugPrint("Error in FetchLocationUseCaseImpl: \(error.localizedDescription)")
            throw error
        }
    }
}
