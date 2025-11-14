//
//  DatabaseView.swift
//  RickMorty
//
//  Created by Uri on 13/11/25.
//

import SwiftUI

struct DatabaseView: View {
    
    @Environment(\.databaseViewModel) private var databaseViewModel
    
    @State private var showAlertOnEndOfList: Bool = false
    
    // MARK: - Navigation to other views
    @State private var showFiltersSheet: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                databaseWallpaper
                
                VStack(spacing: 0) {
                    fullHeader
                    scrollableCharactersList
                }
                
            }
            .searchable(text: Binding(
                get: { databaseViewModel.searchText },
                set: { databaseViewModel.searchText = $0 }
            ),
                        prompt: "Search displayed characters")
            .toolbar(.hidden, for: .navigationBar)
            .persistentSystemOverlays(.hidden)
            .task {
                await databaseViewModel.loadCharacters()
            }
            .alert(isPresented: $showAlertOnEndOfList) {
                allCharactersLoadedAlert()
            }
            .sheet(isPresented: $showFiltersSheet) {
                FiltersSheet(selection: Binding(
                    get: { databaseViewModel.selectedFilterOption },
                    set: { databaseViewModel.selectedFilterOption = $0 }
                ))
                .presentationDetents([.medium])
            }
        }
    }
}

#if DEBUG
#Preview {
    DatabaseView()
        .environment(\.databaseViewModel, DeveloperPreview.instance.databaseViewModel)
}
#endif

extension DatabaseView {
    
    // MARK: - View components
    private var databaseWallpaper: some View {
        Image("databaseWallpaper")
            .resizable()
            .ignoresSafeArea()
            .opacity(0.15)
    }
    
    private var fullHeader: some View {
        VStack {
            // titleheader
            filtersBar
            sortBar
        }
        .padding()
        .padding(.top, -10)
    }
    
    private var filtersBar: some View {
        FiltersBar(filters: databaseViewModel.activeSubfilters,
                   onXMarkPressed: {
            databaseViewModel.selectedFilter = nil
        }, onFilterPressed: { newFilter in
            databaseViewModel.selectedFilter = newFilter
        }, onOptionButtonPressed: {
            showFiltersSheet = true
        }, selectedFilter: databaseViewModel.selectedFilter
        )
        .padding(.leading, -10)
    }
    
    private var sortBar: some View {
        // HSTack counter + spacer + sortmenu
        SortMenu()
    }
    
    private var displayedCardsGrid: some View {
        LazyVGrid(
            columns: Array(repeating: GridItem(.flexible(), spacing: 10), count: 2),
            alignment: .center,
            spacing: 10,
            pinnedViews: [],
            content: {
                ForEach(databaseViewModel.fetchedCharacters) { character in
                    DatabaseCard(character: character,
                                 onCardPressed: {
                        // go to detailview
                    }
                    )
                    .onAppear {
                        if character == databaseViewModel.fetchedCharacters.last &&
                            !databaseViewModel.isFilteringOrSearching {
                            handleEndOfList()
                        }
                    }
                }
            }
        )
        .padding(.horizontal)
    }
    
    private var scrollableCharactersList: some View {
        ScrollViewReader { proxy in
            ScrollView {
                    if databaseViewModel.isLoading && databaseViewModel.fetchedCharacters.isEmpty {
                        ProgressColorBarsView()
                    } else if let error = databaseViewModel.errorMessage {
                        Text(error)
                            .padding()
                    } else {
                        displayedCardsGrid
                        
                        if databaseViewModel.isFilteringOrSearching {
                            FetchMoreDisabledView()
                                .onDisappear {
                                    handleEndOfList()
                                }
                        }
                    }
            }
        }
        .scrollIndicators(.hidden)
    }
    
    // MARK: - Private methods
    private func allCharactersLoadedAlert() -> Alert {
        return Alert(
            title: Text("All characters are loaded"),
            message: Text("You have \(databaseViewModel.fetchedCharactersCount) characters available."),
            dismissButton: .default(Text("OK"))
        )
    }
    
    private func handleEndOfList() {
        if databaseViewModel.canFetchMore {
            Task {
                await databaseViewModel.loadCharacters()
            }
        } else {
            showAlertOnEndOfList = true
        }
    }
}
