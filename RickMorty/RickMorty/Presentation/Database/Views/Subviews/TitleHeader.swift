//
//  TitleHeader.swift
//  RickMorty
//
//  Created by Uri on 15/11/25.
//

import SwiftUI

struct TitleHeader: View {
    
    var body: some View {
        HorizontalLogoImage(isAnimationEnabled: false)
            .shadow(color: .black, radius: 3)
    }
}

#if DEBUG
#Preview {
    TitleHeader()
}
#endif
