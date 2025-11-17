//
//  DetailBottomButtons.swift
//  RickMorty
//
//  Created by Uri on 16/11/25.
//

import SwiftUI

struct DetailBottomButtons: View {
    
    @Environment(\.isPad) var isPad: Bool
    
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
                        .frame(maxWidth: .infinity)
                }
                .RMLimeLook()
                .font(isPad ? .title : .title3)
                .accessibilityHidden(!showOriginButton)
                .accessibilityLabel("View details of character's origin")
            }
            
            if showLocationButton {
                Button {
                    onLocationButtonPressed()
                } label: {
                    Text("Location Details")
                        .frame(maxWidth: .infinity)
                }
                .RMLimeLook()
                .font(isPad ? .title : .title3)
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
