//
//  CounterLabel.swift
//  RickMorty
//
//  Created by Uri on 15/11/25.
//

import SwiftUI

struct CounterLabel: View {
    
    @Environment(\.databaseViewModel) private var databaseViewModel
    
    var body: some View {
        Text("\(databaseViewModel.displayedCharactersCount) of \(databaseViewModel.totalCharacterCount) characters")
            .font(.callout)
            .foregroundStyle(.rmLime)
            .accessibilityLabel("\(databaseViewModel.displayedCharactersCount) Characters displayed. Total characters available are \(databaseViewModel.totalCharacterCount).")
    }
}

#if DEBUG
#Preview {
    CounterLabel()
}
#endif
