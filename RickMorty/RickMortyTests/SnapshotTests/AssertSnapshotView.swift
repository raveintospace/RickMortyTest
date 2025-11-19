//
//  AssertSnapshotView.swift
//  RickMorty
//
//  Created by Uri on 19/11/25.
//

import SwiftUI
import SnapshotTesting

func assertSnapshotView<V: View>(
    _ view: V,
    size: CGSize = .init(width: 300, height: 300),
    file: StaticString = #file,
    testName: String = #function,
    line: UInt = #line
) {
    let vc = UIHostingController(rootView: view)
    vc.view.frame = CGRect(origin: .zero, size: size)
    
    assertSnapshot(
        of: vc,
        as: .image(on: .iPhone13),
        file: file,
        testName: testName,
        line: line
    )
}

