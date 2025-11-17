//
//  TitleHeader.swift
//  RickMorty
//
//  Created by Uri on 15/11/25.
//

import SwiftUI

struct TitleHeader: View {
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.isPad) private var isPad: Bool
    
    var body: some View {
        HStack(spacing: 0) {
            homeButton
            titleImage
            Spacer()
                .frame(maxWidth: .infinity, alignment: .trailing)
                .accessibilityHidden(true)
        }
        
    }
}

#if DEBUG
#Preview {
    TitleHeader()
}
#endif

extension TitleHeader {
    
    private var homeButton: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "house.circle")
                .font(isPad ? .largeTitle : .title)
                .scaleEffect(isPad ? 1.5 : 1.0)
                .tint(.rmLime)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .accessibilityLabel("Go back to home view")
        .accessibilityAddTraits(.isButton)
    }
    
    private var titleImage: some View {
        Image("RMHorizontal")
            .resizable()
            .scaledToFit()
            .frame(maxWidth: .infinity, alignment: .center)
            .shadow(color: .black, radius: 3)
            .accessibilityLabel("Rick and Morty logo")
            .accessibilityAddTraits(.isImage)
    }
}
