//
//  ProgressColorBarsView.swift
//  RickMorty
//
//  Created by Uri on 13/11/25.
//

import SwiftUI

struct ProgressColorBarsView: View {

    @State private var currentIndex: Int = 0

    let colors: [Color] = [.rmYellow, .rmLime, .rmPink]
    var compactMode: Bool = false

    var body: some View {
        HStack(spacing: 10) {
            ForEach(0..<3) { index in
                RoundedRectangle(cornerRadius: 20)
                    .fill(colors[index])
                    .frame(width: compactMode ? 6 : 10,
                           height: currentIndex == index ? (compactMode ? 50 : 200) : (compactMode ? 15 : 30))
                    .animation(.spring(duration: 0.9), value: currentIndex)
            }
        }
        .onAppear {
            startAnimation()
        }
    }
}

#if DEBUG
#Preview {
    VStack {
        ProgressColorBarsView()
        ProgressColorBarsView(compactMode: true)
    }
}
#endif

extension ProgressColorBarsView {

    private func startAnimation() {
        Timer.scheduledTimer(withTimeInterval: 0.30, repeats: true) { _ in
            currentIndex = (currentIndex + 1) % colors.count
        }
    }
}
