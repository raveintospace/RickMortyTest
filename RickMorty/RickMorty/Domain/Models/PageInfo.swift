//
//  PageInfo.swift
//  RickMorty
//
//  Created by Uri on 13/11/25.
//

import Foundation

/// The essential pagination metadata
nonisolated struct PageInfo: Decodable, Sendable {
    let objectCount: Int
    let nextPage: URL?
    
    enum CodingKeys: String, CodingKey {
        case objectCount = "count"
        case nextPage = "next"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.objectCount = try container.decode(Int.self, forKey: .objectCount)
        
        // Api returns nil when we receive the last page available
        let nextString = try container.decodeIfPresent(String.self, forKey: .nextPage)
        self.nextPage = nextString.flatMap { URL(string: $0) }
    }
    
    init(objectCount: Int, nextPage: URL?) {
        self.objectCount = objectCount
        self.nextPage = nextPage
    }
}
