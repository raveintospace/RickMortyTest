//
//  HomeView.swift
//  RickMorty
//
//  Created by Uri on 16/11/25.
//

import SwiftUI

struct HomeView: View {
    
    @Environment(\.isPad) var isPad: Bool
    
    // MARK: - Navigation states
    @State private var showDatabase: Bool = false
    @State private var showEpisodeList: Bool = false
    @State private var showInfoSheet: Bool = false
    
    private let gitHubURL = URL(string: "https://github.com/raveintospace/RickMortyTest")!
    
    var body: some View {
        NavigationStack {
            ZStack {
                RMBackgroundGradientView()
                
                VStack {
                    appLogo
                    Spacer()
                    viewsButtonStack
                    Spacer()
                    if isPad {
                        Spacer()
                    }
                }
                .padding()
            }
            .toolbar(.hidden, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    infoButton
                }
            }
            .sheet(isPresented: $showInfoSheet) {
                infoText
                    .presentationDetents([.medium])
            }
            .fullScreenCover(isPresented: $showDatabase) {
                DatabaseView()
                    .interactiveDismissDisabled()
            }
            .fullScreenCover(isPresented: $showEpisodeList) {
                EpisodeListView()
                    .interactiveDismissDisabled()
            }
        }
    }
}

#if DEBUG
#Preview {
    HomeView()
}
#endif

extension HomeView {
    
    private var appLogo: some View {
        Image("RMHorizontal")
            .resizable()
            .scaledToFit()
            .accessibilityLabel("Rick and Morty logo")
            .accessibilityAddTraits(.isImage)
            .shadow(color: .black, radius: 3)
    }
    
    private var viewsButtonStack: some View {
        VStack(spacing: 20) {
            Button {
                showDatabase = true
            } label: {
                Text("Database")
                    .shadow(color: .rmLime, radius: 1)
                    .frame(width: isPad ? 300 : 150)
            }
            .RMLimeLook()
            .font(isPad ? .title : .title3)
            .accessibilityHint("Navigates to Database view")
            
            Button {
                showEpisodeList = true
            } label: {
                Text("Episode List")
                    .shadow(color: .rmLime, radius: 1)
                    .frame(width: isPad ? 300 : 150)
            }
            .RMLimeLook()
            .font(isPad ? .title : .title3)
            .accessibilityHint("Navigates to Episode List view")
        }
    }
    
    private var infoButton: some View {
        Button {
            showInfoSheet = true
        } label: {
            Image(systemName: "info.circle")
                .font(isPad ? .title : .body)
                .shadow(color: .rmLime, radius: 1)
        }
        .buttonStyle(.glass)
        .shadow(color: .rmLime, radius: 3)
        .controlSize(.large)
        .accessibilityLabel("Show info sheet")
        .accessibilityAddTraits(.isButton)
        .accessibilityHint("Shows an info sheet with details about the app developer")
    }
    
    private var infoText: some View {
        VStack(spacing: 24) {
            Text("This app has been developed by Oriol Angelet.")
                .font(isPad ? .largeTitle : .headline)
                .multilineTextAlignment(.center)
            
            Link("Check the repository here", destination: gitHubURL)
                .font(isPad ? .title : .body)
                .foregroundStyle(.blue)
                .underline()
                .accessibilityLabel("Opens this app repository in web browser.")
            
            DismissSheetButton()
        }
        .shadow(color: .rmLime, radius: 1)
        .modifier(GlassSheetModifier())
        .shadow(color: .rmLime, radius: 3)
        
        
    }
}

