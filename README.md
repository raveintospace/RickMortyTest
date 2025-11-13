# RickMortyTest
Small app to test Rick & Morty API, made with SwiftUI

1. ARCHITECTURE
This project implements an MVVM (Model-View-ViewModel) architecture, structured into four distinct main layers:

- Data Layer: Handles API communication.
- Domain Layer: Defines repositories and use cases.
- Model Layer: Contains the data structures used throughout the app.
- Presentation Layer: Includes ViewModels and UI components.

The MVVM pattern ensures a clear separation of concerns:
- Model: Represents data structures like Character and Comic.
- View: SwiftUI views that display data and handle user interactions.
- ViewModel: Manages business logic, interacts with use cases, and updates the UI.

2. DEPENDENCY INJECTION
To improve modularity and testability, dependencies are injected via protocols into DataSources and UseCases. Protocols are defined in separate files, but I know they could also have been created inside the files that implement each protocol, as there is only one struct for each one. 

3. FRAMEWORKS
Kingfisher to save image cache, it is a solvent third-party library that I've used in my past projects too.

4. CHOICES
 -- nonisolated struct that conforms to Sendable
Marks the structs as independent from any global actor (including the MainActor) and safe to pass between concurrency contexts.

Conforming to Sendable and being nonisolated is required because:
1. The models only contain thread-safe types (Int, String, URL, Enums) and manage no mutable state, making them intrinsically safe to transfer (Sendable).
2. We prevent the compiler, especially in Swift 6 mode, from inferring that the Decodable protocol is bound to the MainActor (default behaviour).
3. It allows the CardCharacterDataSourceImpl actor to return data without costly copies or isolation bridging, ensuring efficiency.

-- The Data Source implementation is declared as an 'actor' to guarantee isolation.
Using an actor is a proactive thread-safety measure because it:
1. Ensures that any future internal state (e.g., an in-memory cache for storing API results) can only be accessed by one thread at a time, eliminating the risk of "data races."
2. Separates and isolates network access logic from the presentation layer (ViewModel), adhering to the Interface Segregation Principle (ISP) and the Dependency Inversion Principle (DIP).

-- No Repository layer
The project does not use several sources to fetch characters (ie network & local cache). The Character's Use Case requests the fetch of characters to the datasource, without using a pass-through repository with no added logic, therefore we avoid unnecessary abstraction

-- Asynchronous Code: async/await instead of completion handlers for API calls and concurrency management.

-- SwiftUI: Instead of UIKit and Storyboards, SwiftUI was used to embrace a fully declarative UI approach, ensuring a more modern and maintainable codebase.

-- Testing Framework: Used Testing instead of XCTest to enhance test readability and maintainability.

-- Some subviews use basic property types (e.g., String, Int, etc.) instead of custom models (e.g., CardCharacter) to enhance reusability across different projects.
