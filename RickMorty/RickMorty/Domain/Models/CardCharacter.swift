//
//  CardCharacter.swift
//  RickMorty
//
//  Created by Uri on 13/11/25.
//

import Foundation

/// The character with the data needed for a Card Character view
struct CardCharacter: Decodable, Identifiable, Equatable {
    let id: Int
    let name: String
    let status: CharacterStatus
    let gender: CharacterGender
    let species: String
    let type: String
    let image: URL
    
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
        self.species = try container.decodeIfPresent(String.self, forKey: .species) ?? "N/A"
        self.type = try container.decodeIfPresent(String.self, forKey: .type) ?? "N/A"
        
        // API returns a String that we convert to a URL if it's a valid one
        let imageString = try container.decode(String.self, forKey: .image)
        guard let imageURL = URL(string: imageString) else {
            throw DecodingError.dataCorruptedError(forKey: .image,
                                                   in: container,
                                                   debugDescription: "Invalid URL string for image")
        }
        self.image = imageURL
    }
}
