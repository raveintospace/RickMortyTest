# RickMortyTest
Small app to test Rick & Morty API, made with SwiftUI

* Choices:
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
