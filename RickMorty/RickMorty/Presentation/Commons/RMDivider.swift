//
//  RMDivider.swift
//  RickMorty
//
//  Created by Uri on 15/11/25.
//

import SwiftUI

struct RMDivider: View {
    
    var negativePadding: CGFloat = -25
    
    var body: some View {
        Divider()
            .overlay(.rmPink)
            .padding(.horizontal, negativePadding)
    }
}

#if DEBUG
#Preview {
    ZStack {
        Color.white.ignoresSafeArea()
        RMDivider()
    }
}
#endif
