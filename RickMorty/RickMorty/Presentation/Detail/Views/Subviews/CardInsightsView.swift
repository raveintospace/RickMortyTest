//
//  CardInsightsView.swift
//  RickMorty
//
//  Created by Uri on 15/11/25.
//

import SwiftUI

struct CardInsightsView: View {
    
    let character: DetailCharacter
    
    @Binding var showSheet: Bool
    @Binding var selectedLocation: CharacterLocation?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            InsightRow(label: "· Gender", value: character.gender.rawValue.capitalized)
            InsightRow(label: "· Status", value: character.status.rawValue.capitalized)
            InsightRow(label: "· Species", value: character.species.capitalized)
            InsightRow(label: "· Type", value: character.type.capitalized)
            
            RMDivider()
            
            episodeLabelFactory()
                .shadow(color: .rmLime, radius: 1)
            
            RMDivider()
            
            LocationLinkView(title: "· Origin", location: character.origin, onTap: handleLocationTap)
            LocationLinkView(title: "· Location", location: character.location, onTap: handleLocationTap)
        }
    }
}

#if DEBUG
#Preview {
    let character = DetailCharacter.Stub.stub10
    let origin = CharacterLocation.Stub.stub1
    let location = CharacterLocation.Stub.stub20
    
    CardInsightsView(character: character, showSheet: .constant(false), selectedLocation: .constant(origin))
        .padding()
}
#endif

extension CardInsightsView {
    
    @ViewBuilder
    private func episodeLabelFactory() -> some View {
        if character.episodeCount > 1 {
            Text("· Appears on **\(character.episodeCount)** episodes.")
                .font(.headline)
                .accessibilityLabel("Character appears on \(character.episodeCount) episodes")
        } else {
            Text("· Appears on **\(character.episodeCount)** episode.")
                .font(.headline)
                .accessibilityLabel("Character appears on one episode")
        }
    }
    
    private func handleLocationTap(location: CharacterLocation) {
        if location.url != nil {
            selectedLocation = location
            showSheet = true
        }
    }
}

fileprivate struct InsightRow: View {
    let label: String
    let value: String
    
    var body: some View {
        HStack(spacing: 4) {
            Text("\(label):")
            Text(value)
                .lineLimit(3)
                .minimumScaleFactor(0.8)
        }
        .font(.headline)
        .shadow(color: .rmLime, radius: 1)
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(label.replacingOccurrences(of: "· ", with: "")). \(value)")
    }
}

fileprivate struct LocationLinkView: View {
    let title: String
    let location: CharacterLocation?
    let onTap: (CharacterLocation) -> Void
    
    var body: some View {
        HStack {
            Text("\(title):")
                .fontWeight(.bold)
            
            if let loc = location {
                Text(loc.name.capitalized)
                    .fontWeight(.medium)
                    .foregroundStyle(loc.url != nil ? .rmLime : .primary)
                    .underline(loc.url != nil)
                    .onTapGesture {
                        if loc.url != nil {
                            onTap(loc)
                        }
                    }
                    .accessibilityAddTraits(loc.url != nil ? .isButton : .isStaticText)
                    .accessibilityHint(loc.url != nil ? "Tap to see further details on a sheet." : "")
            } else {
                Text("N/A")
                    .foregroundColor(.gray)
            }
        }
        .font(.headline)
        .shadow(color: .rmLime, radius: 1)
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(title). \(location?.name.capitalized ?? "Value not available")")
    }
}
