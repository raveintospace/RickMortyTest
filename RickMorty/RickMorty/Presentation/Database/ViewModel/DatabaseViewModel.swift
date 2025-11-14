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
    
    // MARK: - Search characters
    var searchText: String = ""
    
    var isSearching: Bool {
        !searchText.isEmpty
    }
    
    // MARK: - Filters for characters
    private(set) var genderFilters: [Filter] = []
    private(set) var statusFilters: [Filter] = []
    var selectedFilter: Filter? = nil    // A gender or a status
    var selectedFilterOption: FilterOption = .gender {
        didSet {
            if oldValue != selectedFilterOption {
                selectedFilter = nil        // Reset it when changing selectedFilterOption
                Task {
                    await updateActiveSubfilters()
                }
            }
        }
    }
    private(set) var activeSubfilters: [Filter] = []  // Genders (4) or Status (3)
    
    // MARK: - Sort order for characters
    var sortOption: SortOption = .id
    
    // MARK: - Dependency injection
    private let fetchCardCharactersUseCase: FetchCardCharactersUseCaseProtocol
    private let getFiltersUseCase: GetFiltersUseCaseProtocol
    
    init(fetchCardCharactersUseCase: FetchCardCharactersUseCaseProtocol,
         getFiltersUseCase: GetFiltersUseCaseProtocol
    ) {
        self.fetchCardCharactersUseCase = fetchCardCharactersUseCase
        self.getFiltersUseCase = getFiltersUseCase
        
        Task {
            await updateActiveSubfilters()
        }
    }
    
    // MARK: - Fetch characters
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
    
    // MARK: - Load filters
    private func loadGenderFilters() async {
        guard genderFilters.isEmpty else { return }
        
        do {
            self.genderFilters = try await getFiltersUseCase.executeGenderFilters()
        } catch {
            debugPrint("Failed to load gender filters: \(error)")
        }
    }
    
    private func loadStatusFilters() async {
        guard statusFilters.isEmpty else { return }
        
        do {
            self.statusFilters = try await getFiltersUseCase.executeStatusFilters()
        } catch {
            debugPrint("Failed to load status filters: \(error)")
        }
    }
    
    private func updateActiveSubfilters() async {
        switch selectedFilterOption {
        case .gender:
            await loadGenderFilters()
            activeSubfilters = genderFilters
        case .status:
            await loadStatusFilters()
            activeSubfilters = statusFilters
        }
    }
    
    // MARK: - Sort logic
    private func sortCharacters(characters: [CardCharacter]) -> [CardCharacter] {
        switch sortOption {
        case .id:
            return characters.sorted { $0.id < $1.id }
        case .idReversed:
            return characters.sorted { $0.id > $1.id }
        case .name:
            return characters.sorted { $0.name < $1.name }
        case .nameReversed:
            return characters.sorted { $0.name > $1.name }
        }
    }
}
