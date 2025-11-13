//
//  DatabaseCard.swift
//  RickMorty
//
//  Created by Uri on 13/11/25.
//

import SwiftUI

struct DatabaseCard: View {
    
    let character: CardCharacter
    var onCardPressed: (() -> Void)?
    
    var body: some View {
        VStack(alignment: .center) {
            characterImage
            characterInfo
        }
    }
}

#if DEBUG
#Preview {
    
    let previewContent = [CardCharacter.Stub.stub1, CardCharacter.Stub.stub2]
    
    LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 4), count: 2),
              alignment: .center,
              spacing: 4,
              pinnedViews: [],
              content: { ForEach(previewContent) { character in
        DatabaseCard(character: character)
    }
    })
}
#endif

extension DatabaseCard {
    
    private var characterImage: some View {
        ImageLoaderView(url: character.image, contentMode: .fill)
            .clipShape(.rect(cornerRadius: 10))
    }
    
    private var characterInfo: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 0) {
                Text(character.name)
                    .font(.headline)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(character.gender.rawValue)
                    .font(.title3)
                    .frame(width: 20)
            }
            Text("Status: \(character.status.rawValue)")
                .font(.caption)
                .fontWeight(.bold)
            Text("Species: ")
                .font(.caption)
                .fontWeight(.semibold) +
            Text(character.species)
                .font(.caption)
            Text("Type: ")
                .font(.caption)
                .fontWeight(.semibold) +
            Text(character.type)
                .font(.caption)
        }
        .padding(.top, 0)
        .padding(.horizontal)
        .padding(.bottom)
    }
}

/*
 id: 1,
 name: "Rick Sanchez",
 status: .alive,
 gender: .male,
 species: "Human",
 type: "",
 image: generateImageURL(id: 1)
 */
