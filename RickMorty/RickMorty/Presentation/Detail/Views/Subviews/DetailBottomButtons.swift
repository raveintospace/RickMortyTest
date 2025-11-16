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
        VStack(spacing: 12) {
            Button {
                onOriginButtonPressed()
            } label: {
                Text("Origin Details")
                    .shadow(color: .rmLime, radius: 1)
                    .frame(maxWidth: .infinity)
            }
            .detailButtonStyle()
            .accessibilityLabel("View details of character's origin")
            
            Button {
                onLocationButtonPressed()
            } label: {
                Text("Location Details")
                    .shadow(color: .rmLime, radius: 1)
                    .frame(maxWidth: .infinity)
            }
            .detailButtonStyle()
            .accessibilityLabel("View details of character's location")
        }
        
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
            .font(.title2)
            .buttonStyle(.glass)
            .buttonBorderShape(.roundedRectangle(radius: 20))
            .shadow(color: .rmLime, radius: 3)
            .controlSize(.large)
    }
}
