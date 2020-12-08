//
//  MarvelAPI.swift
//  MarvelApp
//
//  Created by James Rochabrun on 12/7/20.
//

import Foundation
import Combine

final class MarvelAPI: CombineAPI {
    
    let session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
    
    func charactersFeed(_ kind: MarvelFeed, retries: Int = 0) -> AnyPublisher<CharacterDataWrapper, Error> {
        execute(kind.request, decodingType: CharacterDataWrapper.self, retries: retries)
    }
}
