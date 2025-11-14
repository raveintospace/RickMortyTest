//
//  GlassSheetModifier.swift
//  RickMorty
//
//  Created by Uri on 14/11/25.
//

import SwiftUI

struct GlassSheetModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .safeAreaPadding()
            .glassEffect(.clear, in: .rect(cornerRadius: 10))
            .shadow(radius: 3)
            .padding(.horizontal)
    }
}
