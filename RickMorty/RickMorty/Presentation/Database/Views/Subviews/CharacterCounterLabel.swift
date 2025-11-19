//
//  CounterLabel.swift
//  RickMorty
//
//  Created by Uri on 15/11/25.
//

import SwiftUI

struct CharacterCounterLabel: View {

    @Environment(\.databaseViewModel) private var databaseViewModel
    @Environment(\.isPad) var isPad: Bool

    private var counterText: String {
        "\(databaseViewModel.displayedCharactersCount) of \(databaseViewModel.totalCharacterCount) characters"
    }

    private var accessibilityLabelText: String {
        """
        \(databaseViewModel.displayedCharactersCount) Characters displayed. \
        Total characters available are \(databaseViewModel.totalCharacterCount).
        """
    }

    var body: some View {
        Text(counterText)
            .font(isPad ? .title : .callout)
            .foregroundStyle(.rmLime)
            .accessibilityLabel(accessibilityLabelText)
    }
}

#if DEBUG
#Preview {
    CharacterCounterLabel()
}
#endif
