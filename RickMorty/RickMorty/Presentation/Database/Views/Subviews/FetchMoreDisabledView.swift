//
//  FetchMoreDisabledView.swift
//  RickMorty
//
//  Created by Uri on 14/11/25.
//

import SwiftUI

struct FetchMoreDisabledView: View {
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: "hand.raised.fill")
                .foregroundColor(.rmYellow)
                .accessibilityHidden(true)

            Text("Unable to fetch more characters")
                .font(.headline)

            Text("Automatic loading of new characters is disabled while filters or search are active.")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .modifier(GlassSheetModifier())
        .accessibilityElement(children: .combine)
        .accessibilityLabel("Automatic loading of new characters is disabled while filters or search are active.")
    }
}

#if DEBUG
#Preview {
    FetchMoreDisabledView()
}
#endif
