//
//  CardInsightsView.swift
//  RickMorty
//
//  Created by Uri on 15/11/25.
//

import SwiftUI

struct CardInsightsView: View {
    
    let character: DetailCharacter
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            InsightRow(label: "· Gender", value: character.gender.rawValue.capitalized)
            InsightRow(label: "· Status", value: character.status.rawValue.capitalized)
            InsightRow(label: "· Species", value: character.species.capitalized)
            InsightRow(label: "· Type", value: character.type.capitalized)
            
            RMDivider()
            
            LocationRow(title: "· Origin", location: character.origin)
            LocationRow(title: "· Location", location: character.location)
            
            RMDivider()
            
            episodeLabel
        }
        .font(.headline)
        .shadow(color: .rmLime, radius: 1)
    }
}

#if DEBUG
#Preview {
    let character = DetailCharacter.Stub.stub10
    
    CardInsightsView(character: character)
        .padding()
}
#endif

extension CardInsightsView {
    
    private var episodeLabel: some View {
        Text(character.episodeCountText)
            .frame(maxWidth: .infinity, alignment: .center)
            .accessibilityLabel(character.episodeCountText)
    }
}

fileprivate struct InsightRow: View {
    let label: String
    let value: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 4) {
            Text("\(label):")
            Text(value)
                .lineLimit(3)
                .fontWeight(.light)
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(label.replacingOccurrences(of: "· ", with: "")). \(value)")
    }
}

fileprivate struct LocationRow: View {
    let title: String
    let location: CharacterLocation?
    
    var body: some View {
        HStack(alignment: .top, spacing: 4) {
            Text("\(title):")
            
            if let loc = location {
                Text(loc.name.capitalized)
                    .fontWeight(.light)
            } else {
                Text("N/A")
                    .fontWeight(.light)
            }
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(title). \(location?.name.capitalized ?? "Value not available")")
    }
}
