//
//  FiltersBar.swift
//  RickMorty
//
//  Created by Uri on 14/11/25.
//

import SwiftUI

struct FiltersBar: View {
    
    @Environment(\.isPad) var isPad: Bool
    
    var filters: [Filter]
    var onXMarkPressed: (() -> Void)?
    var onFilterPressed: ((Filter) -> Void)?
    var onOptionButtonPressed: (() -> Void)?
    
    // The value is passed by the parent view
    var selectedFilter: Filter?
    
    var body: some View {
        HStack(spacing: 0) {
            ScrollViewReader { scrollViewProxy in
                ScrollView(.horizontal) {
                    HStack(spacing: 8) {
                        if selectedFilter != nil {
                            Button {
                                onXMarkPressed?()
                            } label: {
                                Image(systemName: "xmark.circle")
                                    .font(isPad ? .largeTitle : .title)
                                    .tint(.rmLime)
                            }
                            .accessibilityLabel("Clear selected filter")
                            .accessibilityAddTraits(.isButton)
                            .transition(.move(edge: .leading).combined(with: .opacity))
                            .padding(.leading, 4)
                            .padding(.trailing, 4) // avoids hitting another cell
                        }
                        
                        ForEach(filters, id: \.id) { filter in
                            if selectedFilter == nil || selectedFilter == filter {
                                FilterSmallCell(
                                    title: filter.title,
                                    isSelected: selectedFilter == filter
                                )
                                .onTapGesture {
                                    onFilterPressed?(filter)
                                }
                                .transition(.move(edge: .trailing).combined(with: .opacity))
                                .padding(.leading, ((selectedFilter == nil) && filter == filters.first) ? 4 : 0)
                            }
                        }
                    }
                    .padding(8)
                }
                .onChange(of: filters) { _, _ in
                    if let firstFilter = filters.first {
                        scrollViewProxy.scrollTo(firstFilter.id, anchor: .leading)
                    }
                }
                .scrollIndicators(.hidden)
                .animation(.bouncy, value: selectedFilter)
            }
            
            Button {
                onOptionButtonPressed?()
            } label: {
                Image(systemName: "slider.vertical.3")
                    .font(isPad ? .title3 : .body)
                    .padding(10)
                    .tint(.rmLime)
                    .background(
                        Capsule(style: .circular)
                            .stroke(lineWidth: 2)
                            .foregroundStyle(.rmLime)
                            .accessibilityHidden(true))
            }
            .accessibilityLabel("Show filter options")
            .accessibilityAddTraits(.isButton)
        }
    }
}

#if DEBUG
#Preview {
    FiltersBarViewPreview()
}
#endif

// Preview to check if filter logic works
fileprivate struct FiltersBarViewPreview: View {
    
    @State private var filters = Filter.Stub.gender
    @State private var selectedFilter: Filter? = nil
    
    var body: some View {
        FiltersBar(
            filters: filters,
            onXMarkPressed: {
                selectedFilter = nil
            },
            onFilterPressed: { newFilter in
                selectedFilter = newFilter
            },
            onOptionButtonPressed: {
                
            },
            selectedFilter: selectedFilter
        )
    }
}
