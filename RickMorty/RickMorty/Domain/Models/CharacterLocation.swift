//
//  CharacterLocation.swift
//  RickMorty
//
//  Created by Uri on 15/11/25.
//

import Foundation

// Location info displayed on DetailView
nonisolated struct CharacterLocation: Decodable, Sendable {
    let name: String
    let url: URL?
    
    enum CodingKeys: String, CodingKey {
        case name, url
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let rawName = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        let cleanedName = rawName.trimmingCharacters(in: .whitespacesAndNewlines)
        self.name = cleanedName.isEmpty ? "N/A" : cleanedName
        
        // API returns a String that we convert to a URL if it's a valid one
        let urlString = try container.decodeIfPresent(String.self, forKey: .url)
        
        if let string = urlString, !string.isEmpty {
            guard let url = URL(string: string) else {
                throw DecodingError.dataCorruptedError(forKey: .url,
                                                       in: container,
                                                       debugDescription: "Invalid URL string for url")
            }
            self.url = url
        } else {
            self.url = nil
        }
    }
    
    // Init for Stubs and Testing
    init(name: String, url: URL?) {
        self.name = name
        self.url = url
    }
}
