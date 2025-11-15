//
//  CardNameLabel.swift
//  RickMorty
//
//  Created by Uri on 15/11/25.
//

import SwiftUI

struct CardNameLabel: View {
    
    let name: String
    
    var body: some View {
        Text(name.capitalized)
            .font(.title)
            .fontWeight(.bold)
            .multilineTextAlignment(.center)
            .lineLimit(3)
            .minimumScaleFactor(0.7)
            .padding(.horizontal)
            .accessibilityLabel("Character name: \(name)")
            .accessibilityAddTraits(.isStaticText)
    }
}

#if DEBUG
#Preview {
    VStack {
        CardNameLabel(name: DetailCharacter.Stub.stub1.name)
        CardNameLabel(name: DetailCharacter.Stub.stub10.name)
        CardNameLabel(name: DetailCharacter.Stub.stub50.name)
        CardNameLabel(name: "fsafusfhasufhusiafhsdoai uhfuiodsahfguisda hgfoudsah gfuiashoiusahsou diahgasufsadofi fsadfiassa fasdsaffas ")
    }
    
}
#endif
