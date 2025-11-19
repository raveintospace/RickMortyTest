//
//  CharacterGender.swift
//  RickMorty
//
//  Created by Uri on 13/11/25.
//

/// Gender of the characters
enum CharacterGender: String, Decodable {
    case female = "Female"
    case genderless = "Genderless"
    case male = "Male"
    case unknown = "unknown"

    // Computed property used in UI
    var symbol: String {
        switch self {
        case .male:
            return "♂︎"
        case .female:
            return "♀️"
        case .genderless:
            return "⚲"
        case .unknown:
            return "¿?"
        }
    }
}
