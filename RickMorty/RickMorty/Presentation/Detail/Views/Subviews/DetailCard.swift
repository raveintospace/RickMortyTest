//
//  DetailCard.swift
//  RickMorty
//
//  Created by Uri on 15/11/25.
//

import SwiftUI

struct DetailCard: View {
    
    let character: DetailCharacter
    
    @Binding var shouldShowSheet: Bool
    @Binding var selectedLocation: CharacterLocation?
    
    var body: some View {
        VStack(spacing: 8) {
            CardNameLabel(name: character.name)
            CardImageView(id: character.id, imageURL: character.image)
            CardInsightsView(character: character,
                             showSheet: $shouldShowSheet,
                             selectedLocation: $selectedLocation)
        }
        .padding(30)
        .background(
            cardFrame
                .shadow(radius: 10)
                .padding(10)
        )
    }
}

#if DEBUG
#Preview {
    DetailCard(character: DetailCharacter.Stub.stub1,
               shouldShowSheet: .constant(false),
               selectedLocation: .constant(CharacterLocation.Stub.stub20)
    )
}
#endif

extension DetailCard {
    
    private var cardFrame: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .stroke(.rmPink, lineWidth: 6)
                .accessibilityHidden(true)
            
            RoundedRectangle(cornerRadius: 15)
                .stroke(.rmLime, lineWidth: 4)
                .padding(2)
                .accessibilityHidden(true)
            
            RoundedRectangle(cornerRadius: 15)
                .stroke(.rmYellow, lineWidth: 3)
                .padding(4)
                .accessibilityHidden(true)
        }
    }
}
