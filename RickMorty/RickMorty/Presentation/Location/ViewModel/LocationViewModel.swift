//
//  LocationViewModel.swift
//  RickMorty
//
//  Created by Uri on 16/11/25.
//

import Foundation

@Observable
final class LocationViewModel {
    
    private(set) var location: DetailLocation?
    private(set) var isLoading: Bool = false
    private(set) var errorMessage: String?
    
    private let locationURL: URL
    
    // MARK: - Dependency injection
    private let fetchLocationUseCase: FetchLocationUseCaseProtocol
    
    init(locationURL: URL,
         fetchLocationUseCase: FetchLocationUseCaseProtocol
    ) {
        self.locationURL = locationURL
        self.fetchLocationUseCase = fetchLocationUseCase
    }
    
    @MainActor
    func loadLocation() async {
        guard !isLoading else { return }
        
        isLoading = true
        errorMessage = nil
        
        defer { isLoading = false }
        
        do {
            let fetchedLocation = try await fetchLocationUseCase.execute(url: locationURL)
            
            self.location = fetchedLocation
        } catch {
            self.errorMessage = "Error loading the location: \(error.localizedDescription)"
        }
    }
}
