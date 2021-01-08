//
//  CharactersListViewController.swift
//  MarvelApp
//
//  Created by James Rochabrun on 12/6/20.
//

import UIKit
import Combine
import BaseUI
/**
 UIKit implementation
 */

final class CharactersListViewController: UIViewController {

//    private let provider = MarvelProvider()
    private let provider = Provider()

    private var cancellables: Set<AnyCancellable> = []

    private typealias CharactersList = DiffableCollectionView<CharacterDataContainer, CharacterListCell>
    
    private lazy var characterList: CharactersList = {
        var config = UICollectionLayoutListConfiguration(appearance:
                                                            .plain)
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
        
        provider.fetchComics()
        
        provider.$characters.sink { [unowned self] series in
            
            for serie in series {
                print("the serie is \(serie.name)")
            }
//            characterList.applySnapshotWith([dataContainer])
        }.store(in: &cancellables)
        
        
    }
    
//    /// UIKit w
//    private func bindViewModel() {
//        provider.$characterDataWrapper.sink { [unowned self] characterResult in
//            guard let dataContainer = characterResult?.data else { return }
//            characterList.applySnapshotWith([dataContainer])
//        }.store(in: &cancellables)
//    }
}
