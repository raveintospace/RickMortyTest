//
//  CardCharacter.swift
//  RickMorty
//
//  Created by Uri on 13/11/25.
//

import Foundation

/// The character with the data needed for a Card Character view
nonisolated struct CardCharacter: Decodable, Identifiable, Equatable, Sendable {
    let id: Int
    let name: String
    let status: CharacterStatus
    let gender: CharacterGender
    let species: String
    let type: String
    let image: URL?
    
    enum CodingKeys: String, CodingKey {
        case id, name, status, species, type, gender, image
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
    }
    
    // Init for Stubs and Testing
    init(id: Int, name: String, status: CharacterStatus, gender: CharacterGender, species: String, type: String, image: URL) {
        self.id = id
        self.name = name
        self.status = status
        self.gender = gender
        self.species = species.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? "N/A" : species
        self.type = type.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? "N/A" : type
        self.image = image
    }
}
