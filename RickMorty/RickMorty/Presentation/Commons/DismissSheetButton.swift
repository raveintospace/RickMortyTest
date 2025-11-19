//
//  DismissSheetButton.swift
//  RickMorty
//
//  Created by Uri on 14/11/25.
//

import SwiftUI

struct DismissSheetButton: View {

    @Environment(\.dismiss) private var dismiss
    @Environment(\.isPad) var isPad: Bool

    var body: some View {
        Button {
            dismiss()
        } label: {
            Text("Close")
                .font(isPad ? .title : .headline)
                .frame(maxWidth: .infinity)
        }
        .shadow(color: .rmLime, radius: 1)
        .buttonStyle(.glass)
        .foregroundStyle(.red)
        .accessibilityHint("Closes this sheet")
    }
}

#if DEBUG
#Preview {
    DismissSheetButton()
}
#endif
