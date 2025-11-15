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
    var callToActionText: String
    
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
                .accessibilityLabel("Icon: \(imageName.replacingOccurrences(of: ".slash", with: "").replacingOccurrences(of: ".", with: " ").capitalized) indicating no results")
                .accessibilityAddTraits(.isImage)
            
            Text(mainText)
                .font(.largeTitle)
                .bold()
            
            Text(callToActionText)
                .font(.callout)
        }
        .modifier(GlassSheetModifier())
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(mainText). \(callToActionText).")
        .accessibilityAddTraits(.isStaticText)
    }
}

#if DEBUG
#Preview {
    NoResultsView(
        imageName: "person.slash",
        mainText: "No characters",
        callToActionText: "There are no characters that match your search. Try with other filters or keywords."
    )
}
#endif
