//
//  InsightRow.swift
//  RickMorty
//
//  Created by Uri on 17/11/25.
//

import SwiftUI

struct InsightRow: View {
    
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
