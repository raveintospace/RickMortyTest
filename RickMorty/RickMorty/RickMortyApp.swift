//
//  RickMortyApp.swift
//  RickMorty
//
//  Created by Uri on 13/11/25.
//

import SwiftUI

@main
struct RickMortyApp: App {
    
    // ViewModels
    private let databaseViewModel: DatabaseViewModel
    
    init() {
        let dataService = DataService()
        let dataSource = CardCharacterDataSourceImpl(dataService: dataService)
        let fetchCardCharactersUseCase = FetchCardCharactersUseCaseImpl(dataSource: dataSource)
        
        self.databaseViewModel = DatabaseViewModel(fetchCardCharactersUseCase: fetchCardCharactersUseCase)
    }
    
    var body: some Scene {
        WindowGroup {
            DatabaseView()
        }
        .environment(\.databaseViewModel, databaseViewModel)
    }
}
