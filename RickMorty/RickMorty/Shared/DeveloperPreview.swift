//
//  DeveloperPreview.swift
//  RickMorty
//
//  Created by Uri on 13/11/25.
//

import SwiftUI

@MainActor
final class DeveloperPreview {
    
    static let instance = DeveloperPreview()
    
    private let dataService: DataService
    private let dataSource: CardCharacterDataSourceImpl
    private let fetchCardCharactersUseCase: FetchCardCharactersUseCaseImpl
    
    let databaseViewModel: DatabaseViewModel
    
    private init() {
        self.dataService = DataService()
        self.dataSource = CardCharacterDataSourceImpl(dataService: dataService)
        self.fetchCardCharactersUseCase = FetchCardCharactersUseCaseImpl(dataSource: dataSource)
        self.databaseViewModel = DatabaseViewModel(fetchCardCharactersUseCase: fetchCardCharactersUseCase)
    }
}
