//
//  CharacterHorizontalView.swift
//  MarvelApp
//
//  Created by James Rochabrun on 12/8/20.
//

import SwiftUI

struct CharacterHorizontalView: View {
    
    var characterViewModel: CharacterViewModel
    
    var body: some View {
        ZStack {
            CarachterArtworkView(artworkViewModel: characterViewModel.artwork, variant: .landscapeMedium)
            VStack(spacing: 5) {
                Text(characterViewModel.name)
                Text(characterViewModel.description)
            }
        }
    }
}

struct CharacterHorizontalView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterHorizontalView(characterViewModel: CharacterViewModel(model: Character(id: nil, name: nil, description: nil, modified: nil, resourceURI: nil, urls: nil, thumbnail: nil)))
    }
}
