//
//  DetailView.swift
//  RickMorty
//
//  Created by Uri on 15/11/25.
//

import SwiftUI

struct DetailView: View {
    
    @State private var detailViewModel: DetailViewModel
    
    let characterID: Int
    
    // MARK: - Navigation to sheets
    @State private var activeSheet: LocationSheet? = nil
    
    private var isPad: Bool {
        UIDevice.current.userInterfaceIdiom == .pad
    }
    
    init(characterID: Int) {
        _detailViewModel = State(initialValue: DetailViewModel(characterID: characterID, fetchDetailCharacterUseCase: FetchDetailCharacterUseCaseImpl(dataSource: DetailCharacterDataSourceImpl(dataService: DataService()))))
        
        self.characterID = characterID
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                detailWallpaper
                
                if detailViewModel.isLoading && detailViewModel.character == nil {
                    ProgressColorBarsView()
                } else if let error = detailViewModel.errorMessage {
                    Text(error)
                        .font(.title3)
                        .foregroundStyle(.rmLime)
                        .padding()
                } else if let character = detailViewModel.character {
                    ScrollView {
                        VStack {
                            DetailCard(character: character)
                            
                            DetailBottomButtons(
                                showOriginButton: character.hasValidOriginURL,
                                onOriginButtonPressed: {
                                    if let url = character.origin?.url {
                                        activeSheet = .origin(url: url)
                                    }
                                },
                                showLocationButton: character.hasValidLocationURL,
                                onLocationButtonPressed: {
                                    if let url = character.location?.url {
                                        activeSheet = .location(url: url)
                                    }
                                }
                            )
                        }
                    }
                    .scrollIndicators(.hidden)
                    .sheet(item: $activeSheet) { sheet in
                        switch sheet {
                        case .origin(let url):
                            LocationView(locationURL: url, locationTitle: "Origin")
                                .presentationDetents(isPad ? [.large] : [.medium, .large])
                        case .location(let url):
                            LocationView(locationURL: url, locationTitle: "Location")
                                .presentationDetents(isPad ? [.large] : [.medium, .large])
                        }
                    }
                }
            }
        }
        .task {
            await detailViewModel.loadCharacter()
        }
    }
}

#if DEBUG
#Preview {
    NavigationStack {
        DetailView(characterID: DetailCharacter.Stub.stub1.id)
    }
}
#endif

extension DetailView {
    private var detailWallpaper: some View {
        Image("detailWallpaper")
            .resizable()
            .ignoresSafeArea()
            .opacity(0.15)
    }
}

fileprivate enum LocationSheet: Identifiable {
    case origin(url: URL)
    case location(url: URL)
    
    var id: String {
        switch self {
        case .origin: return "origin"
        case .location: return "location"
        }
    }
}
