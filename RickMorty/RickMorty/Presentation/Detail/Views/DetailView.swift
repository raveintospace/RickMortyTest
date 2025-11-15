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
                    VStack {
                        Text(character.name)
                        Text(character.species)
                        Text("\(character.episodeCount)")
                        Text(character.origin?.name ?? "Fato")
                        Text(character.location?.name ?? "Fato")
                        Text(character.status.rawValue)
                    }
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
