//
//  DetailCharacter.swift
//  RickMorty
//
//  Created by Uri on 15/11/25.
//

import Foundation

// The character displayed on DetailView
nonisolated struct DetailCharacter: Decodable, Sendable {
    let id: Int
    let name: String
    let status: CharacterStatus
    let gender: CharacterGender
    let species: String
    let type: String
    let image: URL?
    let episode: [String]
    
    // Nested objects - User may navigate to a sheet to see further details about them
    let origin: CharacterLocation?
    let location: CharacterLocation?
    
    // Computed properties for UI
    var episodeCount: Int {
        episode.count
    }
    
    var episodeCountText: String {
        switch episodeCount {
        case 0:
            return "· Appears on no episodes ·"
        case 1:
            return "· Appears on 1 episode ·"
        default:
            return "· Appears on \(episodeCount) episodes ·"
        }
    }
    
    var hasValidOriginURL: Bool {
        return origin?.url != nil
    }
    
    var hasValidLocationURL: Bool {
        return location?.url != nil
    }
    
    enum CodingKeys: String, CodingKey {
        case id, name, status, gender, species, type, image, episode, origin, location
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.status = try container.decode(CharacterStatus.self, forKey: .status)
        self.gender = try container.decode(CharacterGender.self, forKey: .gender)
        
        // These properties are not of "closed nature", we use fallback "N/A" if key is missing or nil
        let rawSpecies = try container.decodeIfPresent(String.self, forKey: .species) ?? ""
        let cleanedSpecies = rawSpecies.trimmingCharacters(in: .whitespacesAndNewlines)
        self.species = cleanedSpecies.isEmpty ? "N/A" : cleanedSpecies
        
        let rawType = try container.decodeIfPresent(String.self, forKey: .type) ?? ""
        let cleanedType = rawType.trimmingCharacters(in: .whitespacesAndNewlines)
        self.type = cleanedType.isEmpty ? "N/A" : cleanedType
        
        /// API returns a String that we convert to a URL?.
        /// We use `decodeIfPresent` and check for an empty string ("") to ensure robust decodability.
        /// If the URL is null, empty, or invalid, the property is set to nil,
        /// preventing a `DecodingError.dataCorruptedError` that would abort the decoding of the entire object.
        /// Our ImageLoaderView has a placeholder image if image = nil
        let imageString = try container.decodeIfPresent(String.self, forKey: .image)
        
        if let string = imageString, !string.isEmpty {
            self.image = URL(string: string)
        } else {
            self.image = nil
        }
        
        let episodeURLs = try container.decodeIfPresent([String].self, forKey: .episode) ?? []
        self.episode = episodeURLs
        
        // CharacterLocation has a fallback if its properties are null
        self.origin = try container.decodeIfPresent(CharacterLocation.self, forKey: .origin)
        self.location = try container.decodeIfPresent(CharacterLocation.self, forKey: .location)
    }
    
    // Init for Stubs and Testing
    init(id: Int, name: String, status: CharacterStatus, gender: CharacterGender, species: String, type: String, image: URL?, episode: [String], origin: CharacterLocation?, location: CharacterLocation?) {
        self.id = id
        self.name = name
        self.status = status
        self.gender = gender
        self.species = species
        self.type = type
        self.image = image
        self.episode = episode
        self.origin = origin
        self.location = location
    }
}
