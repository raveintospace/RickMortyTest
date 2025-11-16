//
//  TitleHeader.swift
//  RickMorty
//
//  Created by Uri on 15/11/25.
//

import SwiftUI

struct TitleHeader: View {
    
    var body: some View {
        Image("RMHorizontal")
            .resizable()
            .scaledToFit()
            .accessibilityLabel("Rick and Morty logo")
            .accessibilityAddTraits(.isImage)
            .shadow(color: .black, radius: 3)
    }
}

#if DEBUG
#Preview {
    TitleHeader()
}
#endif
