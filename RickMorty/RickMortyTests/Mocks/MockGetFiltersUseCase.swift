//
//  MockGetFiltersUseCase.swift
//  RickMorty
//
//  Created by Uri on 14/11/25.
//

import Foundation
@testable import RickMorty

struct MockGetFiltersUseCase: GetFiltersUseCaseProtocol {
    
    func executeGenderFilters() async throws -> [Filter] {
        return Filter.Stub.gender
    }
    
    func executeStatusFilters() async throws -> [Filter] {
        return Filter.Stub.status
    }
}

