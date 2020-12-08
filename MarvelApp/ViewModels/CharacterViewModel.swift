//
//  CharacterViewModel.swift
//  MarvelApp
//
//  Created by James Rochabrun on 12/7/20.
//

import Foundation

struct CharacterViewModel {

    let name: String
    let description: String
    let artwork: ArtworkViewModel?
    
    init?(model: Character) {
        name = model.name ?? "no name provided"
        description = model.description ?? "no despcription provided"
        artwork = ArtworkViewModel(artWork: model.thumbnail)
    }
}


