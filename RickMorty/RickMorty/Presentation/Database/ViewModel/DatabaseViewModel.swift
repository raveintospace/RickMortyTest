//
//  DatabaseViewModel.swift
//  RickMorty
//
//  Created by Uri on 13/11/25.
//

import Foundation

@Observable
final class DatabaseViewModel {
    
    // MARK: - Properties
    private(set) var characters: [CardCharacter] = []
    private(set) var totalCharacterCount: Int = 0
    private(set) var isLoading: Bool = false
    private(set) var canLoadMore: Bool = true
    
    private(set) var currentPage: Int = 1
    
    private(set) var errorMessage: String?
    
    var downloadedCharactersCount: Int {
        characters.count
    }
    
    // MARK: - Dependency injection
    private let fetchCardCharactersUseCase: FetchCardCharactersUseCaseProtocol
    
    init(fetchCardCharactersUseCase: FetchCardCharactersUseCaseProtocol) {
        self.fetchCardCharactersUseCase = fetchCardCharactersUseCase
    }
    
    // MARK: - Public methods
    func loadCharacters() async {
        guard !isLoading && canLoadMore else { return }
        
        await MainActor.run {
            self.isLoading = true
            self.errorMessage = nil // Clean previous errors
        }
        
        do {
            let response = try await fetchCardCharactersUseCase.execute(page: currentPage)
            
            await MainActor.run {
                self.characters.append(contentsOf: response.results)
                
                self.totalCharacterCount = response.info.objectCount
                
                // Update properties for the next fetch
                self.canLoadMore = response.info.nextPage != nil
                self.currentPage += 1
            }
        } catch {
            await MainActor.run {
                self.errorMessage = "Error loading characters on page \(self.currentPage): \(error.localizedDescription)"
                self.canLoadMore = false
            }
        }
        
        await MainActor.run {
            self.isLoading = false
        }
    }
}
