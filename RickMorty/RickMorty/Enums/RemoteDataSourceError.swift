//
//  RemoteDataSourceError.swift
//  RickMorty
//
//  Created by Uri on 13/11/25.
//

/// The specific errors that could happen when fetching remote data
enum RemoteDataSourceError: Error {
    case badServerResponse
    case decodingError(Error)
    case httpError(statusCode: Int)
    case invalidURL
}
