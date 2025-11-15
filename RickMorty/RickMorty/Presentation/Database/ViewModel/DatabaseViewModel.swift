//
//  DatabaseViewModel.swift
//  RickMorty
//
//  Created by Uri on 13/11/25.
//

import Foundation

@Observable
final class DatabaseViewModel {
    
    // MARK: - Basic properties
    private(set) var fetchedCharacters: [CardCharacter] = []
    private(set) var totalCharacterCount: Int = 0
    
    var fetchedCharactersCount: Int {
        fetchedCharacters.count
    }
    
    var displayedCharacters: [CardCharacter] {
        return sortCharacters(characters: filterCharacters(searchText: searchText,
                                                           selectedFilter: selectedFilter,
                                                           characters: fetchedCharacters))
    }
    
    var displayedCharactersCount: Int {
        displayedCharacters.count
    }
    
    // MARK: - Fetch properties
    private(set) var isLoading: Bool = false
    private(set) var canFetchMore: Bool = true
    private(set) var currentPage: Int = 1
    private(set) var errorMessage: String?
    
    // MARK: - Search characters
    private var searchDebounceTask: Task<Void, Error>?
    
    var searchText: String = "" {
        didSet {
            searchDebounceTask?.cancel()
            
            searchDebounceTask = Task {
                try await Task.sleep(for: .milliseconds(300)) // 3 seconds
                
                try Task.checkCancellation()
            }
        }
    }
    
    var isSearching: Bool {
        !searchText.isEmpty
    }
    
    // MARK: - Computed properties for UI when filtering or searching
    var isFilteringOrSearching: Bool {
        return selectedFilter != nil || !searchText.isEmpty
    }
    
    var noResultsForFilter: Bool {
        return displayedCharacters.isEmpty && selectedFilter != nil
    }
    
    var noResultsForSearchText: Bool {
        return displayedCharacters.isEmpty && !searchText.isEmpty
    }
    
    var showNoResultsView: Bool {
        return noResultsForFilter || noResultsForSearchText
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
    @MainActor
    func loadCharacters() async {
        guard !isLoading && canFetchMore else { return }
        
        self.isLoading = true
        self.errorMessage = nil // Clean previous errors
        
        defer { isLoading = false }
        
        do {
            let response = try await fetchCardCharactersUseCase.execute(page: currentPage)
            
            self.fetchedCharacters.append(contentsOf: response.results)
            
            self.totalCharacterCount = response.info.objectCount
            
            // Update properties for the next fetch
            self.canFetchMore = response.info.nextPage != nil
            self.currentPage += 1
        } catch {
            self.errorMessage = "Error loading characters on page \(self.currentPage): \(error.localizedDescription)"
            self.canFetchMore = false
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
    
    @MainActor
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
    
    // MARK: - Filter logic, combining searchText & Filters
    private func filterCharacters(searchText: String,
                                  selectedFilter: Filter?,
                                  characters: [CardCharacter]) -> [CardCharacter] {
        var filtered = characters
        
        // SearchText filtering
        if !searchText.isEmpty {
            let search = searchText.lowercased()
            
            filtered = filtered.filter { character in
                let nameContainsSearch = character.name.lowercased().contains(search)
                let genderContainsSearch = character.gender.rawValue.lowercased().contains(search)
                let statusContainsSearch = character.status.rawValue.lowercased().contains(search)
                let speciesContainsSearch = character.species.lowercased().contains(search)
                let typeContainsSearch = character.type.lowercased().contains(search)
                
                return nameContainsSearch || genderContainsSearch || statusContainsSearch || speciesContainsSearch ||
                typeContainsSearch
            }
        }
        
        // Apply Filters (Gender or Status)
        if let filter = selectedFilter {
            filtered = applyFilter(filter: filter, characters: filtered)
        }
        
        return filtered
    }
    
    // MARK: - Filter logic with Filters only
    private func applyFilter(filter: Filter, characters: [CardCharacter]) -> [CardCharacter] {
        let filterTitle = filter.title.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        return characters.filter { character in
            switch selectedFilterOption {
            case .gender:
                return character.gender.rawValue.lowercased().trimmingCharacters(in: .whitespacesAndNewlines) == filterTitle
            case .status:
                return character.status.rawValue.lowercased().trimmingCharacters(in: .whitespacesAndNewlines) == filterTitle
            }
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
