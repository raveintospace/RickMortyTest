//
//  KingfisherImageLoader.swift
//  RickMorty
//
//  Created by Uri on 13/11/25.
//

import SwiftUI
import Kingfisher

struct KingfisherImageLoader: View {
    
    let imageUrl: URL
    var contentMode: SwiftUI.ContentMode = .fill

    var body: some View {
        KFImage(imageUrl)
            .placeholder {
                Image("RMPlaceholder")
                    .resizable()
                    .grayscale(1)
            }
            .resizable()
            .onProgress({ _, _ in

            })
            .onSuccess({ _ in

            })
            .onFailure({ _ in

            })
            .aspectRatio(contentMode: contentMode)
    }
}

#if DEBUG
#Preview {
    let wrongurl = URL(string: "fsafsd")!
    
    VStack {
        KingfisherImageLoader(imageUrl: CardCharacter.Stub.stub1.image, contentMode: .fit)
            .frame(width: 200, height: 200)
        KingfisherImageLoader(imageUrl: wrongurl)
            .frame(width: 200, height: 200)
    }
    
}
#endif
