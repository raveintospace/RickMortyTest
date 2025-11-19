//
//  PageInfo+Stub.swift
//  RickMorty
//
//  Created by Uri on 13/11/25.
//

import Foundation

#if DEBUG
extension PageInfo {

    nonisolated enum Stub {
        // MARK: - Characters
        static let stubCharacterPage1 = PageInfo(
            objectCount: 826,
            nextPage: URL(string: APIConstants.charactersListURL + "page=2")!
        )

        static let stubCharacterPage2 = PageInfo(
            objectCount: 826,
            nextPage: URL(string: APIConstants.charactersListURL + "page=3")!
        )

        static let stubCharacterPage42 = PageInfo(
            objectCount: 826,
            nextPage: nil
        )

        // MARK: - Episodes
        static let stubEpisodePage1 = PageInfo(
            objectCount: 51,
            nextPage: URL(string: APIConstants.episodesListURL + "page=2")!
        )

        static let stubEpisodePage3 = PageInfo(
            objectCount: 51,
            nextPage: nil
        )
    }
}
#endif
