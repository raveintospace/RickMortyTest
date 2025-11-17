//
//  EpisodeListView.swift
//  RickMorty
//
//  Created by Uri on 17/11/25.
//

import SwiftUI

struct EpisodeListView: View {
    
    @Environment(\.isPad) var isPad: Bool
    
    @State private var episodeListViewModel: EpisodeListViewModel
    
    @State private var showAlertEndOfList: Bool = false
    
    init() {
        _episodeListViewModel = State(initialValue: EpisodeListViewModel(fetchEpisodesUseCase: FetchEpisodesUseCaseImpl(dataSource: EpisodeDataSourceImpl(dataService: DataService()))))
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                // listWallpaper
                
                VStack(spacing: 0) {
                    // header
                    scrollableEpisodeList
                }
            }
            .toolbar(.hidden, for: .navigationBar)
            .persistentSystemOverlays(.hidden)
            .task {
                if episodeListViewModel.fetchedEpisodes.isEmpty {
                    await episodeListViewModel.loadEpisodes()
                }
            }
            .alert(isPresented: $showAlertEndOfList) {
                allEpisodesLoadedAlert()
            }
        }
    }
}

#if DEBUG
#Preview {
    EpisodeListView()
}
#endif

extension EpisodeListView {
    
    private var displayedEpisodes: some View {
        LazyVStack(spacing: 12) {
            ForEach(episodeListViewModel.fetchedEpisodes) { episode in
                EpisodeCard(episode: episode)
                    .onAppear {
                        if episode == episodeListViewModel.fetchedEpisodes.last {
                            handleEndOfList()
                        }
                    }
            }
        }
    }
    
    private var scrollableEpisodeList: some View {
        ScrollView {
            Group {
                if episodeListViewModel.isLoading && episodeListViewModel.fetchedEpisodes.isEmpty {
                    ProgressColorBarsView()
                } else if let error = episodeListViewModel.errorMessage {
                    Text(error)
                        .font(.title3)
                        .foregroundStyle(.rmLime)
                        .padding()
                } else {
                    displayedEpisodes
                }
            }
        }
        .scrollIndicators(.visible)
    }
    
    private func allEpisodesLoadedAlert() -> Alert {
        return Alert(
            title: Text("All episodes are loaded"),
            message: Text("You have \(episodeListViewModel.fetchedEpisodesCount) episodes available."),
            dismissButton: .default(Text("OK"))
        )
    }
    
    private func handleEndOfList() {
        if episodeListViewModel.canFetchMore {
            Task {
                await episodeListViewModel.loadEpisodes()
            }
        } else {
            showAlertEndOfList = true
        }
    }
}
