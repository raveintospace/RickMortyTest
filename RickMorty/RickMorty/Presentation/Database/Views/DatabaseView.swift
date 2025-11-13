//
//  DatabaseView.swift
//  RickMorty
//
//  Created by Uri on 13/11/25.
//

import SwiftUI

struct DatabaseView: View {
    
    @Environment(\.databaseViewModel) private var databaseViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.rmYellow.ignoresSafeArea().opacity(0.1)
                
                ScrollView {
                    LazyVGrid(
                        columns: Array(repeating: GridItem(.flexible(), spacing: 10), count: 2),
                        alignment: .center,
                        spacing: 10,
                        pinnedViews: [],
                        content: {
                            ForEach(databaseViewModel.characters) { character in
                                DatabaseCard(character: character)
                            }
                        }
                    )
                    .padding(.horizontal)
                }
                
            }
            .task {
                await databaseViewModel.loadCharacters()
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
