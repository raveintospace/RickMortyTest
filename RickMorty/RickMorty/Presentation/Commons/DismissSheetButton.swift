//
//  DismissSheetButton.swift
//  RickMorty
//
//  Created by Uri on 14/11/25.
//

import SwiftUI

struct DismissSheetButton: View {
    
    @Environment(\.dismiss) private var dismiss
    
    private var isPad: Bool {
        UIDevice.current.userInterfaceIdiom == .pad
    }
    
    var body: some View {
        Button {
            dismiss()
        } label: {
            Text("Close")
                .font(isPad ? .title : .headline)
                .frame(maxWidth: .infinity)
        }
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
