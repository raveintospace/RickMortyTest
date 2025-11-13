//
//  PageInfo+Stub.swift
//  RickMorty
//
//  Created by Uri on 13/11/25.
//

import Foundation

extension PageInfo {
    
    enum Stub {
        static let stub1 = PageInfo(
            objectCount: 20,
            nextPage: URL(string: APIConstants.charactersListURL + "page=2")!
        )
        
        static let stub2 = PageInfo(
            objectCount: 20,
            nextPage: URL(string: APIConstants.charactersListURL + "page=3")!
        )
        
        static let stub42 = PageInfo(
            objectCount: 20,
            nextPage: nil
        )
    }
}
