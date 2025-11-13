//
//  PageInfo.swift
//  RickMorty
//
//  Created by Uri on 13/11/25.
//

import Foundation

/// The essential pagination metadata
nonisolated struct PageInfo: Decodable, Sendable {
    let characterCount: Int
    let nextPage: URL?
    
    enum CodingKeys: String, CodingKey {
        case characterCount = "count"
        case nextPage = "next"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.characterCount = try container.decode(Int.self, forKey: .characterCount)
        
        // Api returns nil when we receive the last page available
        let nextString = try container.decodeIfPresent(String.self, forKey: .nextPage)
        self.nextPage = nextString.flatMap { URL(string: $0) }
    }
}
