//
//  SortMenu.swift
//  RickMorty
//
//  Created by Uri on 14/11/25.
//

import SwiftUI

struct SortMenu: View {
    
    @Environment(\.databaseViewModel) private var databaseViewModel
    
    var body: some View {
        HStack {
            Menu {
                ForEach(SortOption.allCases, id: \.self) { sortOption in
                    Button(action: {
                        databaseViewModel.sortOption = sortOption
                    }) {
                        sortOption.displayName()
                    }
                }
            } label: {
                menuTitleView(sortOption: databaseViewModel.sortOption)
            }
            .tint(.rmLime)
            .frame(maxWidth: .infinity, alignment: .trailing)
        }
    }
}

#if DEBUG
#Preview {
    SortMenu()
        .padding()
}
#endif

// Accessibility is set in displayName's declaration on Enum SortOption
extension SortMenu {
    private func menuTitleView(sortOption: SortOption) -> some View {
        sortOption.displayName()
    }
}
