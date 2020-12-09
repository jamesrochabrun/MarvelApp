//
//  CharacterListCell.swift
//  MarvelApp
//
//  Created by James Rochabrun on 12/8/20.
//

import UIKit
import SwiftUI

final class CharacterListCell: BaseCollectionViewCell<CharacterViewModel> {
    
    var hostView: HostView<CharacterHorizontalView>?
    
    override func setupWith(_ viewModel: CharacterViewModel, parent: UIViewController?) {
        
        guard let parent = parent else { fatalError() }
        let characterListView = CharacterHorizontalView(characterViewModel: viewModel)
        let hostView = HostView(parent: parent, view: characterListView)
        self.hostView = hostView
        contentView.addSubview(hostView)
        hostView.fillSuperview()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        hostView?.removeFromSuperview()
        hostView = nil
    }
}
