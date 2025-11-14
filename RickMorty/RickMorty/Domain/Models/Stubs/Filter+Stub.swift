//
//  Filter+Stub.swift
//  RickMorty
//
//  Created by Uri on 14/11/25.
//

import Foundation

extension Filter {
    enum Stub {
        static let gender: [Filter] = [
            Filter(title: "Female"),
            Filter(title: "Genderless"),
            Filter(title: "Male"),
            Filter(title: "Unknown")
        ]
        
        static let status: [Filter] = [
            Filter(title: "Alive"),
            Filter(title: "Dead"),
            Filter(title: "Unknown")
        ]
    }
}
