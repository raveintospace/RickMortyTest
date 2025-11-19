//
//  EpisodePageResponse.swift
//  RickMorty
//
//  Created by Uri on 17/11/25.
//

import Foundation

nonisolated struct EpisodePageResponse: Decodable, Sendable {
    let info: PageInfo
    let results: [Episode]
}
