//
//  EpisodePageResponse+Stub.swift
//  RickMorty
//
//  Created by Uri on 17/11/25.
//

import Foundation

#if DEBUG
extension EpisodePageResponse {
    
    enum Stub {
        static let stub1 = EpisodePageResponse(
            info: PageInfo.Stub.stubEpisodePage1,
            results: [Episode.Stub.stub1, Episode.Stub.stub2])
        
        static let stub2 = EpisodePageResponse(
            info: PageInfo.Stub.stubEpisodePage3,
            results: [Episode.Stub.stub5])
    }
}
#endif
