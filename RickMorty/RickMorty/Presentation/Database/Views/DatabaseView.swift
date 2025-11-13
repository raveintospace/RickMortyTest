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
            ScrollView {
                LazyVGrid(
                    columns: Array(repeating: GridItem(.flexible(), spacing: 8), count: 2),
                    alignment: .center,
                    spacing: 8,
                    pinnedViews: [],
                    content: {
                        ForEach(databaseViewModel.characters) { character in
                            VStack {
                                Text(character.name)
                                Text("\(character.id)")
                                Text(character.gender.rawValue)
                                Text(character.status.rawValue)
                                Text(character.species)
                                Text(character.type)
                                Text("\(character.image)")
                            }
                        }
                    }
                )
                .padding(.horizontal)
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
