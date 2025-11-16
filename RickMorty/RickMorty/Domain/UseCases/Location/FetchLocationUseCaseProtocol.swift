//
//  FetchLocationUseCaseProtocol.swift
//  RickMorty
//
//  Created by Uri on 16/11/25.
//

import Foundation

// Defines the contract for fetching a DetailLocation for a sheet
protocol FetchLocationUseCaseProtocol {
    
    /// Retrieves a DetailLocation from the API
    func execute(url: URL) async throws -> DetailLocation
}
