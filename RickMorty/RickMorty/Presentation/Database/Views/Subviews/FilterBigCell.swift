//
//  FilterBigCell.swift
//  RickMorty
//
//  Created by Uri on 13/11/25.
//

import SwiftUI

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
                .padding(8)
                .fontWeight(selection == filterOption ? .semibold : .light)
        }
        .buttonStyle(.glass)
        .foregroundStyle(selection == filterOption ? .rmLime : .primary)
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
