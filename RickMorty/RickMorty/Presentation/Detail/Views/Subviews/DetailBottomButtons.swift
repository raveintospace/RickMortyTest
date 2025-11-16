//
//  DetailBottomButtons.swift
//  RickMorty
//
//  Created by Uri on 16/11/25.
//

import SwiftUI

struct DetailBottomButtons: View {
    
    var showOriginButton: Bool
    var onOriginButtonPressed: () -> Void
    
    var showLocationButton: Bool
    var onLocationButtonPressed: () -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            if showOriginButton {
                Button {
                    onOriginButtonPressed()
                } label: {
                    Text("Origin Details")
                        .shadow(color: .rmLime, radius: 1)
                        .frame(maxWidth: .infinity)
                }
                .detailButtonStyle()
                .accessibilityHidden(!showOriginButton)
                .accessibilityLabel("View details of character's origin")
            }
            
            if showLocationButton {
                Button {
                    onLocationButtonPressed()
                } label: {
                    Text("Location Details")
                        .shadow(color: .rmLime, radius: 1)
                        .frame(maxWidth: .infinity)
                }
                .detailButtonStyle()
                .accessibilityHidden(!showLocationButton)
                .accessibilityLabel("View details of character's location")
            }
        }
        .padding(.horizontal, 40)
        
    }
}

#if DEBUG
#Preview {
    DetailBottomButtons(showOriginButton: true,
                        onOriginButtonPressed: {},
                        showLocationButton: true,
                        onLocationButtonPressed: {})
}
#endif

extension Button {
    
    func detailButtonStyle() -> some View {
        self
            .font(.title3)
            .buttonStyle(.glass)
            .buttonBorderShape(.roundedRectangle(radius: 15))
            .shadow(color: .rmLime, radius: 3)
            .controlSize(.large)
    }
}
