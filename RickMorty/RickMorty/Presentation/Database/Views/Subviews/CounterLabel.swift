//
//  CounterLabel.swift
//  RickMorty
//
//  Created by Uri on 15/11/25.
//

import SwiftUI

struct CounterLabel: View {
    
    @Environment(\.databaseViewModel) private var databaseViewModel
    @Environment(\.isPad) var isPad: Bool
    
    var body: some View {
        Text("\(databaseViewModel.displayedCharactersCount) of \(databaseViewModel.totalCharacterCount) characters")
            .font(isPad ? .title : .callout)
            .foregroundStyle(.rmLime)
            .accessibilityLabel("\(databaseViewModel.displayedCharactersCount) Characters displayed. Total characters available are \(databaseViewModel.totalCharacterCount).")
    }
}

#if DEBUG
#Preview {
    CounterLabel()
}
#endif
