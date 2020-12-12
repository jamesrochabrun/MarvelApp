//
//  CharacterViewModel.swift
//  MarvelApp
//
//  Created by James Rochabrun on 12/7/20.
//

import Foundation

struct CharacterViewModel: Identifiable {

    let id = UUID()

    let name: String
    let description: String
    let artwork: ArtworkViewModel?
    
    init(model: Character) {
        name = model.name ?? "no name provided"
        description = model.description ?? "no despcription provided"
        artwork = ArtworkViewModel(artWork: model.thumbnail)
    }
}

// Diffable DataSource conformance
extension CharacterViewModel: Hashable {
    
    static func == (lhs: CharacterViewModel, rhs: CharacterViewModel) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

