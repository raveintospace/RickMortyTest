//
//  CardNameLabel.swift
//  RickMorty
//
//  Created by Uri on 15/11/25.
//

import SwiftUI

struct CardNameLabel: View {
    
    let name: String
    
    private var isPad: Bool {
        UIDevice.current.userInterfaceIdiom == .pad
    }
    
    var body: some View {
        Text(name.capitalized)
            .font(isPad ? .largeTitle : .title)
            .fontWeight(.bold)
            .multilineTextAlignment(.center)
            .lineLimit(3)
            .minimumScaleFactor(0.7)
            .shadow(color: .rmLime, radius: 2)
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
