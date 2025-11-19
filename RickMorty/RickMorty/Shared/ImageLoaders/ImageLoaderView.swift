//
//  ImageLoaderView.swift
//  RickMorty
//
//  Created by Uri on 13/11/25.
//

import SwiftUI

/// Generic image loader, no need to import Kingfisher
/// We can add several SDKs with this struct (if SDWeb... else Kingfisher)
struct ImageLoaderView: View {

    let url: URL?
    var contentMode: ContentMode = .fit

    /// .allowsHitTesting(false) - only rectangle frame is clickable
    var allowHitTesting: Bool = false

    var body: some View {
        KingfisherImageLoader(imageUrl: url, contentMode: contentMode)
            .allowsHitTesting(allowHitTesting)
    }
}

#if DEBUG
#Preview {
    ImageLoaderView(url: CardCharacter.Stub.stub2.image)
        .frame(width: 200, height: 200)
        .clipShape(.rect(cornerRadius: 10))
}
#endif
