//
//  DetailView.swift
//  RickMorty
//
//  Created by Uri on 15/11/25.
//

import SwiftUI

struct DetailView: View {
    
    @State private var detailViewModel: DetailViewModel
    
    // MARK: - Navigation to sheets
    @State private var showOriginSheet: Bool = false
    @State private var showLocationSheet: Bool = false
    
    let characterID: Int
    
    init(characterID: Int) {
        _detailViewModel = State(initialValue: DetailViewModel(characterID: characterID, fetchDetailCharacterUseCase: FetchDetailCharacterUseCaseImpl(dataSource: DetailCharacterDataSourceImpl(dataService: DataService()))))
        
        self.characterID = characterID
    }
    
    var body: some View {
        NavigationStack {
            Group {
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
                                    showOriginSheet = true
                                },
                                showLocationButton: character.hasValidLocationURL,
                                onLocationButtonPressed: {
                                    showLocationSheet = true
                                }
                            )
                        }
                    }
                    .scrollIndicators(.hidden)
                }
            }
            .task {
                await detailViewModel.loadCharacter()
            }
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
