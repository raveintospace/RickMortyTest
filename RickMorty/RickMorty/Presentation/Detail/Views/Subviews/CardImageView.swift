//
//  CardImageView.swift
//  RickMorty
//
//  Created by Uri on 15/11/25.
//

import SwiftUI

struct CardImageView: View {
    
    let id: Int
    let imageURL: URL?
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            ImageLoaderView(url: imageURL)
                .fixedSize()
                .clipShape(RoundedRectangle(cornerRadius: 5))
            
            Text("#\(id)")
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundStyle(.black)
                .padding(20)
                .background(.rmLime)
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .stroke(.rmYellow, lineWidth: 3)
                )
                .padding(5)
                .offset(y: -5)
        }
        .overlay(
            RoundedRectangle(cornerRadius: 5)
                .stroke(.rmYellow, lineWidth: 3)
        )
    }
}

#if DEBUG
#Preview {
    let character = DetailCharacter.Stub.stub1
    
    CardImageView(id: 150, imageURL: character.image)
        .safeAreaPadding()
}
#endif
