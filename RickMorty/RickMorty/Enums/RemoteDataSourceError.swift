//
//  RemoteDataSourceError.swift
//  RickMorty
//
//  Created by Uri on 13/11/25.
//

/// The specific errors that could happen when fetching remote data
enum RemoteDataSourceError: Error, Equatable {
    case badServerResponse
    case decodingError(Error)
    case httpError(statusCode: Int)
    case invalidURL
    
    static func == (lhs: RemoteDataSourceError, rhs: RemoteDataSourceError) -> Bool {
        switch (lhs, rhs) {
        case (.badServerResponse, .badServerResponse):
            return true
        case (.invalidURL, .invalidURL):
            return true
        case (.httpError(let lhsCode), .httpError(let rhsCode)):
            return lhsCode == rhsCode
        case (.decodingError, .decodingError):
            return true
        default:
            return false
        }
    }
}
