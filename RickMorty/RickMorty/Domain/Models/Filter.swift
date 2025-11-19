//
//  Filter.swift
//  RickMorty
//
//  Created by Uri on 14/11/25.
//

import SwiftUI

struct Filter: Hashable, Equatable, Identifiable {
    let id: UUID
    let title: String

    init(id: UUID = UUID(), title: String) {
        self.id = id
        self.title = title
    }
}
