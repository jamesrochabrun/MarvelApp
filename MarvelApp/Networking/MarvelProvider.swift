//
//  MarvelProvider.swift
//  MarvelApp
//
//  Created by James Rochabrun on 12/7/20.
//

import Foundation
import Combine


final class Provider: ObservableObject {


    private let service = MarvelService()

    @Published var series: [Serie] = []
    @Published var characters: [Character] = []
    @Published var comics: [Comic] = []
    
    func fetchSeries() {
        MarvelService().fetch(MarvelData<Resources<Serie>>.self) { resource in
            switch resource {
            case .success(let results):
                self.series = results
            case .failure: break
            }
        }
    }

    func fetchCharacters() {
        MarvelService().fetch(MarvelData<Resources<Character>>.self) { resource in
            switch resource {
            case .success(let results):
                self.characters = results
            case .failure: break
            }
        }
    }

    func fetchComics() {
        MarvelService().fetch(MarvelData<Resources<Comic>>.self) { resource in
            switch resource {
            case .success(let results):
                self.comics = results
            case .failure: break
            }
        }
    }
}



final class MarvelProvider: ObservableObject {
    
    private var cancellable: AnyCancellable?
    
    @Published var characterDataWrapper: CharacterDataWrapper?
    
    private let client = MarvelAPI()
    
    func fetch() {
        cancellable = client.charactersFeed(.characters)
            .sink(receiveCompletion: { vale in
                print("the value is \(vale)")
            },
            receiveValue: {
                self.characterDataWrapper = $0
            })
    }

}
