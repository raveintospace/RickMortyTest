//
//  LoadingErrorText.swift
//  RickMorty
//
//  Created by Uri on 17/11/25.
//

import SwiftUI

struct RMErrorText: View {
    
    let error: String
    
    var body: some View {
        Text(error)
            .font(.title)
            .foregroundStyle(.rmLime)
            .padding()
    }
}

#if DEBUG
#Preview {
    RMErrorText(error: "Some error")
}
#endif
