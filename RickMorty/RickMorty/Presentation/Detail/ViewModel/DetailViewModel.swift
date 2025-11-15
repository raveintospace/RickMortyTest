//
//  DetailViewModel.swift
//  RickMorty
//
//  Created by Uri on 15/11/25.
//

import Foundation

@Observable
final class DetailViewModel {
    
    private(set) var character: DetailCharacter?
    private(set) var isLoading: Bool = false
    private(set) var errorMessage: String?
    
    private let characterID: Int
    
    // MARK: - Dependency injection
    private let fetchDetailCharacterUseCase: FetchDetailCharacterUseCaseProtocol
    
    init(characterID: Int,
        fetchDetailCharacterUseCase: FetchDetailCharacterUseCaseProtocol
    ) {
        self.characterID = characterID
        self.fetchDetailCharacterUseCase = fetchDetailCharacterUseCase
    }
    
    @MainActor
    func loadCharacter() async {
        guard !isLoading else { return }
        
        isLoading = true
        errorMessage = nil
        
        defer { isLoading = false }
        
        do {
            let fetchedCharacter = try await fetchDetailCharacterUseCase.execute(id: characterID)
            
            self.character = fetchedCharacter
        } catch {
            self.errorMessage = "Error loading the character: \(error.localizedDescription)"
        }
    }
}
