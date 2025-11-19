//
//  EnvironmentKeys.swift
//  RickMorty
//
//  Created by Uri on 13/11/25.
//

import SwiftUI

/// EnvironmentKeys
///
/// This file defines the SwiftUI Environment Keys used for **Dependency Injection (DI)** via the
/// native `@Environment` mechanism.
/// This allows core services and ViewModels to be easily accessed from any View in the
/// hierarchy without manual initialization or explicit passing of parameters.

// MARK: - DatabaseViewModel
/// The `defaultValue` is configured to use Mock/Dummy Repositories to ensure
/// Previews and fallback code can compile.
/// We don't need to declare a SessionViewModel object in Previews, they read this automatically
private struct DatabaseViewModelKey: EnvironmentKey {
    
    static let defaultValue: DatabaseViewModel = {
        
        #if DEBUG
        let mockFetchUseCase = MockPreviewFetchCardCharactersUseCase()
        let mockFiltersUseCase = MockPreviewGetFiltersUseCase()
        
        return DatabaseViewModel(
            fetchCardCharactersUseCase: mockFetchUseCase,
            getFiltersUseCase: mockFiltersUseCase
        )
        
        #else
        fatalError("DatabaseViewModelKey.defaultValue should not be accessed in Production.")
        #endif
    }()
}

// Allows DatabaseViewModel access using @Environment(\.databaseViewModel)
// We can pass a concrete value if we mock the DatabaseViewModel (ie: .environment(\.databaseViewModel, myMock)
extension EnvironmentValues {
    var databaseViewModel: DatabaseViewModel {
        get { self[DatabaseViewModelKey.self] }
        set { self[DatabaseViewModelKey.self] = newValue }
    }
}

/// Check if device is of type iPad
/// Views can adapt to it being bigger than on iPhone
private struct IsPadKey: EnvironmentKey {
    
    static let defaultValue: Bool = UIDevice.current.userInterfaceIdiom == .pad
}

extension EnvironmentValues {
    var isPad: Bool {
        get { self[IsPadKey.self] }
        set { self[IsPadKey.self] = newValue }
    }
}
