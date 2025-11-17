//
//  EpisodeCard.swift
//  RickMorty
//
//  Created by Uri on 17/11/25.
//

import SwiftUI

struct EpisodeCard: View {
    
    @Environment(\.isPad) var isPad: Bool
    
    let episode: Episode
    
    var body: some View {
        VStack(alignment: .leading) {
            episodeTitle
            
            InsightRow(label: "Aired on", value: episode.airDate)
            InsightRow(label: "Episode code", value: episode.episodeCode)
                .padding(.bottom, 8)
            
            RMDivider(negativePadding: 0)
            
            episodeCharacterCountLabel
        }
        .font(isPad ? .title : .headline)
        .modifier(GlassSheetModifier())
        .shadow(color: .rmLime, radius: 3)
        .accessibilityElement(children: .combine)
        .accessibilityAddTraits(.isStaticText)
    }
}

#if DEBUG
#Preview {
    EpisodeCard(episode: Episode.Stub.stub1)
}
#endif

extension EpisodeCard {
    
    private var episodeTitle: some View {
        Text(episode.name)
            .font(isPad ? .largeTitle : .title3)
            .lineLimit(3)
            .underline()
            .multilineTextAlignment(.leading)
            .minimumScaleFactor(0.7)
            .bold()
            .padding(.bottom, 8)
            .accessibilityAddTraits(.isHeader)
            .accessibilityLabel("Episode title: \(episode.name)")
    }
    
    private var episodeCharacterCountLabel: some View {
        Text(episode.characterCountText)
            .padding(.top, 10)
            .lineLimit(2)
            .minimumScaleFactor(0.7)
            .accessibilityLabel(episode.characterCountText)
    }
}
