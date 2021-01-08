//
//  CharacterListView.swift
//  MarvelApp
//
//  Created by James Rochabrun on 12/11/20.
//

import SwiftUI
import UIKit

struct CharacterListView: View {
    
    var characterViewModel: CharacterViewModel
    var imagesVariant: ImageVariant
    
    var body: some View {
        HStack(alignment: .top, spacing: 20) {
            CarachterArtworkView(artworkViewModel: characterViewModel.artwork, variant: imagesVariant)
                .frame(width: 80, height: 80)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            VStack(alignment: .leading, spacing: 7) {
                Text(characterViewModel.name)
                    .bold()
                    .font(.title)
                    .foregroundColor(.black)
                Text(characterViewModel.description)
                    .font(.headline)
                    .foregroundColor(.black)
            }
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.horizontal, 20)
        .padding(.vertical, 20)

    }
}

//struct CharacterListView_Previews: PreviewProvider {
//    static var previews: some View {
//        CharacterListView(characterViewModel: CharacterViewModel(model: Character(name: nil, characterDescription: nil, modified: nil, resourceURI: nil, urls: nil, thumbnail: nil)), imagesVariant: .portraitSmall)
//
//        Preview(viewController: CharactersListViewController())
//                   .environment(\.colorScheme, .light)
//                   .edgesIgnoringSafeArea(.all)
//    }
//}

public struct Preview<ViewControllerType: UIViewController>: UIViewControllerRepresentable {
    
    let viewController: ViewControllerType
    public func makeUIViewController(context: Context) -> ViewControllerType {
        viewController
    }
    public func updateUIViewController(_ viewController: ViewControllerType, context: Context) {
    }
}
