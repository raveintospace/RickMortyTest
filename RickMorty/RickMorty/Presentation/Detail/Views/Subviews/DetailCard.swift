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
        
        VStack(spacing: 0) {
            CardNameLabel(name: character.name)
        }
    }
}

#if DEBUG
#Preview {
    DetailCard(character: DetailCharacter.Stub.stub1)
}
#endif
