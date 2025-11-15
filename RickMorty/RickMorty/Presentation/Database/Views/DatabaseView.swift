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
    @State private var showDetailView: Bool = false
    @State private var selectedCharacter: CardCharacter?
    
    // MARK: - ScrollList behaviour
    @State private var setScrollToZero: Bool = false
    
    // iPad detector
    private var isPad: Bool {
        UIDevice.current.userInterfaceIdiom == .pad
    }
    
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
            ), prompt: "Search displayed characters")
            .onSubmit(of: .search) {
                setScrollToZero = true
            }
            .toolbar(isPad ? .visible : .hidden, for: .navigationBar)
            .persistentSystemOverlays(.hidden)
            .task {
                if databaseViewModel.fetchedCharacters.isEmpty {
                    await databaseViewModel.loadCharacters()
                }
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
            .navigationDestination(isPresented: $showDetailView) {
                if let character = selectedCharacter {
                    DetailView()
                }
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
            databaseTitleHeader
            filtersBar
            sortBar
        }
        .padding()
        .padding(.top, -20)
    }
    
    private var databaseTitleHeader: some View {
        TitleHeader()
            .frame(height: 50)
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
        HStack {
            CounterLabel()
            SortMenu()
        }
        
    }
    
    private var noCharactersView: some View {
        NoResultsView(imageName: "person.slash",
                      mainText: "No Characters",
                      callToActionText: "There are no characters that match your search. Try with other filters or keywords.")
    }
    
    private var displayedCardsGrid: some View {
        LazyVGrid(
            columns: Array(repeating: GridItem(.flexible(), spacing: isPad ? 20: 10), count: isPad ? 3 : 2),
            alignment: .center,
            spacing: isPad ? 20: 10,
            pinnedViews: [],
            content: {
                ForEach(databaseViewModel.displayedCharacters) { character in
                    DatabaseCard(character: character,
                                 onCardPressed: {
                        segue(character: character)
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
                Group {
                    if databaseViewModel.isLoading && databaseViewModel.fetchedCharacters.isEmpty {
                        ProgressColorBarsView()
                    } else if let error = databaseViewModel.errorMessage {
                        Text(error)
                            .font(.title3)
                            .foregroundStyle(.rmLime)
                            .padding()
                    } else if databaseViewModel.showNoResultsView {
                        noCharactersView
                    } else {
                        displayedCardsGrid
                        
                        if databaseViewModel.isFilteringOrSearching {
                            FetchMoreDisabledView()
                        }
                    }
                }
                .id(0)
            }
            .scrollIndicators(.visible)
            .onChange(of: databaseViewModel.sortOption) { _, _ in
                withAnimation(.smooth) { proxy.scrollTo(0, anchor: .top) }
            }
            .onChange(of: databaseViewModel.selectedFilter) { _, _ in
                withAnimation(.smooth) { proxy.scrollTo(0, anchor: .top) }
            }
            .onChange(of: setScrollToZero) { _, _ in
                withAnimation(.smooth) { proxy.scrollTo(0, anchor: .top) }
            }
        }
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
    
    private func segue(character: CardCharacter) {
        selectedCharacter = character
        showDetailView = true
    }
}
