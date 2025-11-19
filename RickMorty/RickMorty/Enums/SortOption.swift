//
//  SortOption.swift
//  RickMorty
//
//  Created by Uri on 13/11/25.
//

import SwiftUI

enum SortOption: String, CaseIterable {
    case id, idReversed, name, nameReversed

    private var baseName: String {
        switch self {
        case .id, .idReversed:
            return "ID"
        case .name, .nameReversed:
            return "Name"
        }
    }

    private var isReversed: Bool {
        switch self {
        case .idReversed, .nameReversed:
            return true
        default:
            return false
        }
    }

    func displayName() -> some View {
        HStack(spacing: 4) {
            Text(baseName)
            Image(systemName: self.isReversed ? "chevron.up" : "chevron.down")
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel(accessibilityDescription)
        .accessibilityAddTraits(.isStaticText)
    }

    var accessibilityDescription: String {
        let orderDescription = isReversed ? "descending" : "ascending"

        switch self {
        case .id, .idReversed:
            return "Sort by character ID, \(orderDescription)"
        case .name, .nameReversed:
            return "Sort by Name, \(orderDescription)"
        }
    }
}
