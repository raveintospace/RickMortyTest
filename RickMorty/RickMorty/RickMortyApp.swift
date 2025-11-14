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
        let filtersRepository = FiltersRepositoryImpl()
        let getFiltersUseCase = GetFiltersUseCaseImpl(repository: filtersRepository)
        
        self.databaseViewModel = DatabaseViewModel(
            fetchCardCharactersUseCase: fetchCardCharactersUseCase,
            getFiltersUseCase: getFiltersUseCase
        )
    }
    
    var body: some Scene {
        WindowGroup {
            DatabaseView()
        }
        .environment(\.databaseViewModel, databaseViewModel)
    }
}
