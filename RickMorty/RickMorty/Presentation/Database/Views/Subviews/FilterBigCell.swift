//
//  FilterBigCell.swift
//  RickMorty
//
//  Created by Uri on 13/11/25.
//

import SwiftUI

/// Button style is set on FiltersSheet
struct FilterBigCell: View {
    
    let filterOption: FilterOption
    
    @Binding var selection: FilterOption
    
    var action: (() -> Void)?
    
    var body: some View {
        Button {
            action?()
        } label: {
            Text(filterOption.displayName)
                .font(.largeTitle)
          //      .fontWeight(selection == filterOption ? .semibold : .light)
                .padding(14)
        }
        .foregroundStyle(selection == filterOption ? .rmLime : .primary)
        .background(
            Capsule(style: .circular)
                .stroke(lineWidth: 2)
                .foregroundStyle(selection == filterOption ? .rmLime : .primary)
                .accessibilityHidden(true)
        )
        .accessibilityElement(children: .combine)
        .accessibilityLabel("Select \(filterOption.displayName) filter")
        .accessibilityAddTraits(selection == filterOption ? [.isSelected, .isButton] : [.isButton])
        .accessibilityHint(selection == filterOption ? "Currently selected filter" : "Tap to choose this filter")
    }
}

#if DEBUG
#Preview {
    FilterBigCellPreview()
}
#endif

fileprivate struct FilterBigCellPreview: View {
    @State private var selectedFilterOption: FilterOption = .gender
    
    var body: some View {
        VStack(spacing: 30) {
            FilterBigCell(filterOption: .gender, selection: $selectedFilterOption) {
                selectedFilterOption = .gender
            }
            FilterBigCell(filterOption: .status, selection: $selectedFilterOption) {
                selectedFilterOption = .status
            }
        }
        .padding()
    }
}
