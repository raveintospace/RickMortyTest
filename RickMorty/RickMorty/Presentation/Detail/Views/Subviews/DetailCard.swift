//
//  DetailCard.swift
//  RickMorty
//
//  Created by Uri on 15/11/25.
//

import SwiftUI

struct DetailCard: View {
    
    let character: DetailCharacter
    
    var body: some View {
        VStack(spacing: 8) {
            CardNameLabel(name: character.name)
                .padding(.bottom, 4)
            CardImageView(id: character.id, imageURL: character.image)
                .layoutPriority(1)
                .padding(.bottom, 6)
            CardInsightsView(character: character)
                .layoutPriority(0)
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
    DetailCard(character: DetailCharacter.Stub.stub1)
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
