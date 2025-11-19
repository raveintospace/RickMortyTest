//
//  LocationDetail.swift
//  RickMorty
//
//  Created by Uri on 15/11/25.
//

import Foundation

// The Location details displayed on a sheet presented on DetailView
nonisolated struct DetailLocation: Decodable, Equatable, Sendable {
    let name: String
    let type: String
    let dimension: String
    let residents: [String]

    var residentCount: Int {
        residents.count
    }

    // Computed property for UI
    var residentCountText: String {
        switch residentCount {
        case 0:
            return "This location has no residents."
        case 1:
            return "This location has 1 resident."
        default:
            return "This location has \(residentCount) residents."
        }
    }

    enum CodingKeys: String, CodingKey {
        case name, type, dimension, residents
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.name = try container.decode(String.self, forKey: .name)

        // These properties are not of "closed nature", we use fallback "N/A" if key is missing or nil
        let rawType = try container.decodeIfPresent(String.self, forKey: .type) ?? ""
        let cleanedType = rawType.trimmingCharacters(in: .whitespacesAndNewlines)
        self.type = cleanedType.isEmpty ? "N/A" : cleanedType

        let rawDimension = try container.decodeIfPresent(String.self, forKey: .dimension) ?? ""
        let cleanedDimension = rawDimension.trimmingCharacters(in: .whitespacesAndNewlines)
        self.dimension = cleanedDimension.isEmpty ? "N/A" : cleanedDimension

        let residentsURLs = try container.decodeIfPresent([String].self, forKey: .residents) ?? []
        self.residents = residentsURLs

        /*
         let episodeURLs = try container.decodeIfPresent([String].self, forKey: .episode) ?? []
         self.episode = episodeURLs
         */
    }

    // Init for Stubs and Testing
    init(name: String, type: String, dimension: String, residents: [String]) {
        self.name = name
        self.type = type
        self.dimension = dimension
        self.residents = residents
    }
}
