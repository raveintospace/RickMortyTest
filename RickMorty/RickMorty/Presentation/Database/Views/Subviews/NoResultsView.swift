//
//  NoResultsView.swift
//  RickMorty
//
//  Created by Uri on 15/11/25.
//

import SwiftUI

struct NoResultsView: View {

    var imageName: String
    var mainText: String
    var ctaText: String

    private var formattedIconName: String {
        imageName
            .replacingOccurrences(of: ".slash", with: "")
            .replacingOccurrences(of: ".", with: " ")
            .capitalized
    }

    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: imageName)
                .font(.largeTitle)
                .foregroundStyle(.rmPink)
                .background(
                    Circle()
                        .stroke(lineWidth: 3)
                        .foregroundStyle(.rmPink)
                        .frame(width: 55, height: 55)
                        .accessibilityHidden(true)
                )
                .padding(.vertical, 10)
                .accessibilityLabel("Icon: \(formattedIconName) indicating no results")
                .accessibilityAddTraits(.isImage)

            Text(mainText)
                .font(.largeTitle)
                .bold()

            Text(ctaText)
                .font(.callout)
        }
        .modifier(GlassSheetModifier())
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(mainText). \(ctaText).")
        .accessibilityAddTraits(.isStaticText)
    }
}

#if DEBUG
#Preview {
    NoResultsView(
        imageName: "person.slash",
        mainText: "No characters",
        ctaText: "There are no characters that match your search. Try with other filters or keywords."
    )
}
#endif
