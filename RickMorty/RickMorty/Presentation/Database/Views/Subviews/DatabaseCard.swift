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
        ZStack {
            Color.rmLime
                .padding(.vertical, 2)
            
            VStack(alignment: .center) {
                characterImage
                characterInfo
            }
            .foregroundStyle(.black)
            .background(VStackBackground)
        }
        .accessibilityElement(children: .ignore)
        .accessibilityAddTraits(onCardPressed != nil ? .isButton : .isStaticText)
        .accessibilityLabel(accessibilityLabel)
        .accessibilityHint(onCardPressed != nil ? "Go to Detail View" : "")
        .onTapGesture {
            onCardPressed?()
        }
    }
}

#if DEBUG
#Preview {
    
    let previewContent = [CardCharacter.Stub.stub1, CardCharacter.Stub.stub6]
    
    LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 10), count: 2),
              alignment: .center,
              spacing: 4,
              pinnedViews: [],
              content: { ForEach(previewContent) { character in
        DatabaseCard(character: character)
    }
    })
    .padding()
}
#endif

extension DatabaseCard {
    
    // MARK - View components
    private var characterImage: some View {
        ImageLoaderView(url: character.image)
            .clipShape(.rect(cornerRadius: 10))
            .padding(5)
            .accessibilityLabel("Image of \(character.name)")
    }
    
    private var characterInfo: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 0) {
                Text(character.name.capitalized)
                    .font(.headline)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .lineLimit(1)
                    .accessibilityHidden(true)
                Text(character.gender.symbol)
                    .font(.title3)
                    .frame(width: 20)
                    .accessibilityLabel("Gender: \(character.gender.rawValue)")
            }
            LabeledText(label: "ID: ", value: "\(character.id)")
            LabeledText(label: "Status: ", value: character.status.rawValue.capitalized)
                .accessibilityHidden(true)
            LabeledText(label: "Species: ", value: character.species.capitalized)
                .accessibilityHidden(true)
            LabeledText(label: "Type: ", value: character.type.capitalized)
                .accessibilityHidden(true)
        }
        .padding(.top)
        .padding(.horizontal)
        .padding(.bottom)
    }
    
    private var VStackBackground: some View {
        RoundedRectangle(cornerRadius: 10)
            .stroke(.rmYellow, lineWidth: 5)
            .accessibilityHidden(true)
    }
    
    // MARK: - Accessibility
    private var accessibilityLabel: String {
        "Character name: \(character.name). ID: \(character.id). Status: \(character.status.rawValue). Species: \(character.species). Type: \(character.type)"
    }
}

fileprivate struct LabeledText: View {
    let label: String
    let value: String
    
    var body: some View {
        HStack(spacing: 0) {
            Text(label)
                .font(.caption)
                .fontWeight(.semibold)
            Text(value)
                .font(.caption)
        }
        .lineLimit(1)
        .accessibilityElement(children: .combine)
    }
}
