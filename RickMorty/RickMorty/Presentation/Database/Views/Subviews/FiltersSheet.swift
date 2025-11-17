//
//  FiltersSheet.swift
//  RickMorty
//
//  Created by Uri on 14/11/25.
//

import SwiftUI

struct FiltersSheet: View {
    
    @Environment(\.databaseViewModel) private var databaseViewModel
    
    var filterOptions: [FilterOption] = FilterOption.allCases
    
    @Binding var selection: FilterOption
    
    var body: some View {
        VStack(spacing: 30) {
            filtersSheetTitle
            
            ForEach(filterOptions) { filterOption in
                FilterBigCell(filterOption: filterOption, selection: $selection) {
                    databaseViewModel.selectedFilterOption = filterOption
                }
            }
            
            DismissSheetButton()
        }
        .modifier(GlassSheetModifier())
        .shadow(color: .rmLime, radius: 3)
        .toolbar(.hidden, for: .navigationBar)
    }
}

#if DEBUG
#Preview {
    FiltersSheetContainer()
}
#endif

extension FiltersSheet {
    
    private var filtersSheetTitle: some View {
        Text("Select how to filter the characters")
            .bold()
            .font(.title)
            .multilineTextAlignment(.center)
            .padding(.horizontal, 40)
    }
}

fileprivate struct FiltersSheetContainer: View {
    
    @State private var selectedOption: FilterOption = .gender
    
    var body: some View {
        FiltersSheet(selection: $selectedOption)
    }
}
