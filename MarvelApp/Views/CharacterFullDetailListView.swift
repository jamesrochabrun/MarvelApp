//
//  CharacterFullDetailListView.swift
//  MarvelApp
//
//  Created by James Rochabrun on 12/8/20.
//

import SwiftUI

struct CharacterFullDetailListView: View {
    
    var characterViewModel: CharacterViewModel
    var imagesVariant: ImageVariant
    
    var body: some View {
        ZStack {
            CarachterArtworkView(artworkViewModel: characterViewModel.artwork, variant: imagesVariant)
            ZStack {
                Color.black
                    .opacity(0.5)
                    .clipShape(RoundedRectangle(cornerRadius: 30))
                
                VStack(spacing: 10) {
                    Text(characterViewModel.name)
                        .bold()
                        .font(.title)
                        .foregroundColor(.white)
                    Text(characterViewModel.description)
                        .font(.headline)
                        .foregroundColor(.white)
                }
                .padding(.horizontal, 25)
                .padding(.vertical, 20)
            }
            .padding(.horizontal, 40)
            .padding(.vertical, 40)
        }
    }
}

//struct CharacterHorizontalView_Previews: PreviewProvider {
//    static var previews: some View {
//        CharacterFullDetailListView(characterViewModel: CharacterViewModel(model: Character(id: nil, name: nil, description: nil, modified: nil, resourceURI: nil, urls: nil, thumbnail: nil)), imagesVariant: .portraitSmall)
//    }
//}
