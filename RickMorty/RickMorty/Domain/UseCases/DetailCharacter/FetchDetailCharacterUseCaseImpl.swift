//
//  FetchDetailCharacterUseCaseImpl.swift
//  RickMorty
//
//  Created by Uri on 15/11/25.
//

import Foundation

struct FetchDetailCharacterUseCaseImpl: FetchDetailCharacterUseCaseProtocol {
    
    // Dependency injection of the Data source
    private let dataSource: DetailCharacterDataSourceProtocol
    
    init(dataSource: DetailCharacterDataSourceProtocol) {
        self.dataSource = dataSource
    }
    
    func execute(id: Int) async throws -> DetailCharacter {
        do {
            return try await dataSource.getDetailCharacter(id: id)
        } catch {
            debugPrint("Error in FetchDetailCharacterUseCaseImpl: \(error.localizedDescription)")
            throw error
        }
    }
}
