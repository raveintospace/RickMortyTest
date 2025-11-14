//
//  FilterSmallCell.swift
//  RickMorty
//
//  Created by Uri on 14/11/25.
//

import SwiftUI

struct FilterSmallCell: View {
    
    var title: String
    var isSelected: Bool
    
    var body: some View {
        Text(title)
            .foregroundStyle(isSelected ? .rmLime : .primary)
            .fontWeight(isSelected ? .semibold : .light)
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(
                Capsule(style: .circular)
                    .stroke(lineWidth: 1)
                    .accessibilityHidden(true)
            )
            .foregroundStyle(isSelected ? .rmLime : .primary)
            .accessibilityElement(children: .combine)
            .accessibilityLabel(title)
            .accessibilityAddTraits(isSelected ? [.isSelected] : [])
            .accessibilityHint(isSelected ? "Currently selected filter" : "Tap to select this filter")
    }
}

#if DEBUG
#Preview {
    VStack {
        FilterSmallCell(title: "Female", isSelected: false)
        FilterSmallCell(title: "Genderless", isSelected: true)
        FilterSmallCell(title: "Unknown", isSelected: false)
        FilterSmallCell(title: "Alive", isSelected: true)
    }
}
#endif
