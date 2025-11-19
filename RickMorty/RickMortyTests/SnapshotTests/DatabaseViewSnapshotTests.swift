//
//  DatabaseViewSnapshotTests.swift
//  RickMorty
//
//  Created by Uri on 19/11/25.
//

import SwiftUI
import SnapshotTesting
import Testing
@testable import RickMorty

@MainActor
struct DatabaseViewSnapshotTests {
    
    @Test func testDatabaseView_DefaultState() {
        let view = DatabaseView()
            .environment(\.isPad, false)
            .environment(\.databaseViewModel, DeveloperPreview.instance.databaseViewModel)
        
        assertSnapshotView(view)
    }
}
