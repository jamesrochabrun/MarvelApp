//
//  MarvelProvider.swift
//  MarvelApp
//
//  Created by James Rochabrun on 12/7/20.
//

import Foundation
import Combine

final class MarvelProvider: ObservableObject {
    
    private var cancellable: AnyCancellable?
    
    @Published var characterDataWrapper: CharacterDataWrapper?
    
    private let client = MarvelAPI()
    
    init() {
        cancellable = client.charactersFeed(.characters)
            .sink(receiveCompletion: { vale in
                print("the value is \(vale)")
            },
            receiveValue: {
                self.characterDataWrapper = $0
            })
    }
}
