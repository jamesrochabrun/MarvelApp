//
//  ViewController.swift
//  MarvelApp
//
//  Created by James Rochabrun on 12/6/20.
//

import UIKit
import Combine

class ViewController: UIViewController {

    let provider = MarvelProvider()
    private var cancellables: Set<AnyCancellable> = []

    typealias CharactersList = GenericContainerDiffableCollectionView<CharactersResponseContent, CharacterDataContainer, CharacterListCell>
    
    fileprivate lazy var characterList: CharactersList = {
        // layout
        var config = UICollectionLayoutListConfiguration(appearance:
          .insetGrouped)
        config.backgroundColor = .clear
        let layout =
          UICollectionViewCompositionalLayout.list(using: config)
        let moviesList = CharactersList(layout: layout, parent: self)
        return moviesList
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(characterList)
        characterList.fillSuperview()
        bindViewModel()
    }
    
    private func bindViewModel() {
        provider.$characterDataWrapper.sink { [unowned self] characterResult in
            guard let dataContainer = characterResult?.data else { return }
            characterList.applySnapshotWith([dataContainer])
        }.store(in: &cancellables)
    }
}
