//
//  RMBackgroundGradientView.swift
//  RickMorty
//
//  Created by Uri on 16/11/25.
//

import SwiftUI

struct RMBackgroundGradientView: View {
    
    var body: some View {
        ZStack {
            // Base gradient
            LinearGradient(
                colors: [.rmLime, .rmPink, .rmYellow],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            // Overlay
            RadialGradient(
                gradient: Gradient(colors: [.rmYellow.opacity(0.55), .rmPink.opacity(0.0)]),
                center: .center,
                startRadius: 80,
                endRadius: 600
            )
            .blendMode(.screen)
            .ignoresSafeArea()
            
            // Bright effect
            Color.white.opacity(0.08)
                .blendMode(.overlay)
                .ignoresSafeArea()
        }
    }
}

#if DEBUG
#Preview {
    RMBackgroundGradientView()
}
#endif
