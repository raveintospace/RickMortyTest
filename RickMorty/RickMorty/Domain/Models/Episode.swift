//
//  Episode.swift
//  RickMorty
//
//  Created by Uri on 17/11/25.
//

import Foundation

nonisolated struct Episode: Decodable, Identifiable, Equatable, Sendable {
    let id: Int
    let name: String
    let airDate: String
    let episodeCode: String
    let characters: [String]
    
    var characterCount: Int {
        return characters.count
    }
    
    var characterCountText: String {
        switch characterCount {
        case 0:
            return "· There are no characters on this episode ·"
        case 1:
            return "· There is 1 character on this episode ·"
        default:
            return "· There are \(characterCount) characters on this episode ·"
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case id, name, characters
        case airDate = "air_date"
        case episodeCode = "episode"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        
        // Fallback "N/A" if key is missing or null
        let rawAirDate = try container.decodeIfPresent(String.self, forKey: .airDate) ?? ""
        let cleanedAirDate = rawAirDate.trimmingCharacters(in: .whitespacesAndNewlines)
        self.airDate = cleanedAirDate.isEmpty ? "N/A" : cleanedAirDate
        
        let rawEpisodeCode = try container.decodeIfPresent(String.self, forKey: .episodeCode) ?? ""
        let cleanedEpisodeCode = rawEpisodeCode.trimmingCharacters(in: .whitespacesAndNewlines)
        self.episodeCode = cleanedEpisodeCode.isEmpty ? "N/A" : cleanedEpisodeCode
        
        // Fallback empty array if property is nil
        let charactersURLs = try container.decodeIfPresent([String].self, forKey: .characters) ?? []
        self.characters = charactersURLs
    }
    
    init(id: Int, name: String, airDate: String, episodeCode: String, characters: [String]) {
        self.id = id
        self.name = name
        self.airDate = airDate
        self.episodeCode = episodeCode
        self.characters = characters
    }
}
