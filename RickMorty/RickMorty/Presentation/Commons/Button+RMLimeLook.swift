//
//  Button+RMLimeLook.swift
//  RickMorty
//
//  Created by Uri on 17/11/25.
//

import SwiftUI

extension Button {

    /// Green shadow, glass style, rounded rectangle shape and large size
    func RMLimeLook() -> some View {
        self
            .buttonStyle(.glass)
            .buttonBorderShape(.roundedRectangle(radius: 15))
            .shadow(color: .rmLime, radius: 3)
            .controlSize(.large)
    }
}
