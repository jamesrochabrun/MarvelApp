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
    
    @Published var characters: [CharacterViewModel] = []
    
    private let client = MarvelAPI()
    
    init() {
        cancellable = client.charactersFeed(.characters)
            .sink(receiveCompletion: { vale in
                print("the value is \(vale)")
            },
            receiveValue: {
                self.characters = $0.data.results?.compactMap { CharacterViewModel(model: $0) } ?? []
                print("the characters is \(self.characters)")
            })
        
    }
}
