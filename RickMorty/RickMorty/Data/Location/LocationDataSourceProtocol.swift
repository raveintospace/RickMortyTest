//
//  LocationDataSourceProtocol.swift
//  RickMorty
//
//  Created by Uri on 16/11/25.
//

import Foundation

protocol LocationDataSourceProtocol {
    func getLocation(url: URL) async throws -> DetailLocation
}
