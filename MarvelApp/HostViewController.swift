//
//  HostViewController.swift
//  MarvelApp
//
//  Created by James Rochabrun on 12/10/20.
//

import UIKit
import SwiftUI

/**
 Swift UI implementation
 */
final class HostViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let hostView = HostView<MainContentList>(parent: self, view: MainContentList())
        view.addSubview(hostView)
        hostView.fillSuperview()
    }
}

struct MainContentList: View {
    
    @StateObject private var provider = MarvelProvider()

    var body: some View {
        let characters = provider.characterDataWrapper?.data.results?.compactMap { CharacterViewModel(model: $0) } ?? []
        return List(characters) { character in
            CharacterFullDetailListView(characterViewModel: character, imagesVariant: .landscapeMedium)
        }
    }
}
