//
//  SplashView.swift
//  RickMorty
//
//  Created by Uri on 16/11/25.
//

import SwiftUI

struct SplashView: View {
    
    @State private var showLogo = false
    @State private var showCredits = false
    
    // Control to dismiss SplashView
    @Binding var showSplashView: Bool
    
    var body: some View {
        ZStack {
            RMBackgroundGradientView()
            
            if showLogo {
                Image("RMVertical")
                    .splashImageStyle()
                    .opacity(showLogo ? 1 : 0)
                    .animation(.easeOut(duration: 1.2), value: showLogo)
                    .offset(y: -35)
            }
            
            VStack {
                Spacer()
                if showCredits {
                    Image("createdBy")
                        .splashImageStyle()
                        .opacity(showCredits ? 1 : 0)
                        .animation(.easeOut(duration: 1.2), value: showCredits)
                        .padding(.bottom, 20)
                }
            }
        }
        .persistentSystemOverlays(.hidden)
        .statusBarHidden(true)
        .onAppear {
            Task { @MainActor in
                try? await Task.sleep(for: .seconds(0.5))
                withAnimation { showLogo = true }
                
                try? await Task.sleep(for: .seconds(0.75))
                withAnimation { showCredits = true }
                
                try? await Task.sleep(for: .seconds(1.75))
                withAnimation { showCredits = false }
                
                try? await Task.sleep(for: .seconds(0.3))
                withAnimation { showLogo = false }
                
                try? await Task.sleep(for: .seconds(0.3))
                withAnimation { showSplashView = false }
            }
        }
    }
}

#if DEBUG
#Preview {
    SplashView(showSplashView: .constant(true))
}
#endif

extension Image {
    func splashImageStyle() -> some View {
        self
            .resizable()
            .scaledToFit()
            .frame(width: 300)
            .shadow(color: .black, radius: 3)
    }
}
