//
//  CharacterPageResponse+Stub.swift
//  RickMorty
//
//  Created by Uri on 13/11/25.
//

import Foundation

#if DEBUG
extension CharacterPageResponse {

    nonisolated enum Stub {
        static let stub1 = CharacterPageResponse(
            info: PageInfo.Stub.stubCharacterPage1,
            results: [CardCharacter.Stub.stub1, CardCharacter.Stub.stub2])

        static let stub2 = CharacterPageResponse(
            info: PageInfo.Stub.stubCharacterPage2,
            results: [CardCharacter.Stub.stub6, CardCharacter.Stub.stub8])

        static let stub42 = CharacterPageResponse(
            info: PageInfo.Stub.stubCharacterPage42,
            results: [CardCharacter.Stub.stub1, CardCharacter.Stub.stub2])
    }
}
#endif
