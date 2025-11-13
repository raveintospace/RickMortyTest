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
    
    var body: some View {
        NavigationStack {
            ZStack {
                databaseWallpaper
                
                ScrollView {
                    displayedCardsGrid
                }
                
            }
            .toolbar(.hidden, for: .navigationBar)
            .persistentSystemOverlays(.hidden)
            .task {
                await databaseViewModel.loadCharacters()
            }
            .alert(isPresented: $showAlertOnEndOfList) {
                allCharactersLoadedAlert()
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
    
    private var displayedCardsGrid: some View {
        LazyVGrid(
            columns: Array(repeating: GridItem(.flexible(), spacing: 10), count: 2),
            alignment: .center,
            spacing: 10,
            pinnedViews: [],
            content: {
                ForEach(databaseViewModel.characters) { character in
                    DatabaseCard(character: character,
                                 onCardPressed: {
                        // go to detailview
                    }
                    )
                    .onAppear {
                        if character == databaseViewModel.characters.last {
                            handleEndOfList()
                        }
                    }
                }
            }
        )
        .padding()
    }
    
    // MARK: - Private methods
    private func allCharactersLoadedAlert() -> Alert {
        return Alert(
            title: Text("All characters are loaded"),
            message: Text("You have \(databaseViewModel.characters.count) characters available."),
            dismissButton: .default(Text("OK"))
        )
    }
    
    private func handleEndOfList() {
        if databaseViewModel.canLoadMore {
            Task {
                await databaseViewModel.loadCharacters()
            }
        } else {
            showAlertOnEndOfList = true
        }
    }
}
