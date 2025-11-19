//
//  FilterOption.swift
//  RickMorty
//
//  Created by Uri on 13/11/25.
//

import Foundation

enum FilterOption: String, CaseIterable, Identifiable {
    case gender, status

    var id: String { self.rawValue }

    var displayName: String {
        switch self {
        case .gender:
            "Gender"
        case .status:
            "Status"
        }
    }
}
