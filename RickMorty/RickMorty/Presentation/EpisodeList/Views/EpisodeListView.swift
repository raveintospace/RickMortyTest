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
                episodesWallpaper
                
                VStack(spacing: isPad ? 20 : 10) {
                    episodeListTitleHeader
                    episodeCounterLabel
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
    
    private var episodesWallpaper: some View {
        Image("episodesWallpaper")
            .resizable()
            .ignoresSafeArea()
            .opacity(0.075)
    }
    
    private var episodeListTitleHeader: some View {
        TitleHeader()
            .frame(height: isPad ? 100 : 50)
            .padding(.horizontal, isPad ? 30 : 12)
    }
    
    private var episodeCounterLabel: some View {
        Text("\(episodeListViewModel.fetchedEpisodesCount) of \(episodeListViewModel.totalEpisodesCount) episodes")
            .font(isPad ? .largeTitle : .callout)
            .foregroundStyle(.rmLime)
            .accessibilityLabel("\(episodeListViewModel.fetchedEpisodesCount) Episodes displayed. Total episodes available are \(episodeListViewModel.totalEpisodesCount).")
    }
    
    private var displayedEpisodes: some View {
        LazyVStack(spacing: isPad ? 24 : 12) {
            ForEach(episodeListViewModel.fetchedEpisodes) { episode in
                EpisodeCard(episode: episode)
                    .onAppear {
                        if episode == episodeListViewModel.fetchedEpisodes.last {
                            handleEndOfList()
                        }
                    }
            }
        }
        .frame(width: isPad ? 600 : .infinity)
    }
    
    private var scrollableEpisodeList: some View {
        ScrollView {
            Color.clear.frame(height: isPad ? 8 : 4)
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
