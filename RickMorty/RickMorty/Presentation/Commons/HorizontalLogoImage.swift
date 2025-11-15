//
//  HorizontalLogoImage.swift
//  RickMorty
//
//  Created by Uri on 15/11/25.
//

import SwiftUI

struct HorizontalLogoImage: View {
    
    @State private var pulseEffect: Bool = false
    var isAnimationEnabled: Bool = true
    
    var body: some View {
        logoImage
            .scaleEffect(pulseEffect ? 1.0 : 0.9)
            .animation(.easeInOut(duration: 1.7).repeatForever(autoreverses: true), value: pulseEffect)
            .onAppear {
                if isAnimationEnabled {
                    pulseEffect = true
                }
            }
            .onDisappear {
                pulseEffect = false
            }
    }
}

#if DEBUG
#Preview {
    ZStack {
        Color.orange.ignoresSafeArea()
        
        HorizontalLogoImage()
    }
}
#endif

extension HorizontalLogoImage {
    
    private var logoImage: some View {
        Image("RMHorizontal")
            .resizable()
            .scaledToFit()
            .accessibilityLabel("Rick and Morty logo")
            .accessibilityAddTraits(.isImage)
    }
}
