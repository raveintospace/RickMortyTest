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
    
    private var isPad: Bool {
        UIDevice.current.userInterfaceIdiom == .pad
    }
    
    var body: some View {
        ZStack {
            Color.rmLime
                .padding(.vertical, 2)
            
            VStack(alignment: .center, spacing: 0) {
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
                    .font(isPad ? .title : .headline)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .lineLimit(1)
                    .accessibilityHidden(true)
                Text(character.gender.symbol)
                    .font(isPad ? .title : .title3)
                    .frame(width: isPad ? 40 : 20)
                    .accessibilityLabel("Gender: \(character.gender.rawValue)")
            }
            LabeledText(label: "ID: ",
                        value: "\(character.id)")
            .font(isPad ? .title3 : .caption)
            LabeledText(label: "Status: ",
                        value: character.status.rawValue.capitalized)
            .font(isPad ? .title3 : .caption)
            .accessibilityHidden(true)
            LabeledText(label: "Species: ",
                        value: character.species.capitalized)
            .font(isPad ? .title3 : .caption)
            .accessibilityHidden(true)
            LabeledText(label: "Type: ",
                        value: character.type.capitalized)
            .font(isPad ? .title3 : .caption)
            .accessibilityHidden(true)
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 10)
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
                .fontWeight(.semibold)
            Text(value)
        }
        .lineLimit(1)
        .accessibilityElement(children: .combine)
    }
}
