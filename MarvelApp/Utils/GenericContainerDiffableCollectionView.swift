//
//  GenericContainerDiffableCollectionView.swift
//  MarvelApp
//
//  Created by James Rochabrun on 12/8/20.
//

import UIKit

protocol DiffableContent {
    associatedtype DiffableSectionViewModel: DiffableSection
    var sections: [DiffableSectionViewModel] { get set }
    init(sections: [DiffableSectionViewModel])
}

protocol DiffableSection: Hashable {
    associatedtype DiffableViewModel: Hashable
    var viewModels: [DiffableViewModel] { get }
}

/**
 `GenericContainerDiffableCollectionView` is a generic class that can be reused to avoid configuration boilerplate code:
 
 - It can be initialized with any `UICollectionViewLayout`
 - It works for any kind of cell which must be specified as a generic constraint.
    - This cell must be a subclass of `BaseCollectionViewCell`
    - Although it can work with any kind of cell, its usage is limited for noww to just one type.
    - (depending on usage will need to extend to support different cell classes)
 - It currently works for one kind of view Model, although the dataSource handle sections, the items inside of them must be homogeneous. (can use a protocol as viewModel)
 - It takes 2 different  PAT's as generic constraint that defines the data source structure.
 
   ** PAT's to define the generic content in a collection view.**
 
 - **DiffableSection** -
 
    Defines a section inside a collection view, it has an array property that represents the view models in a section.
    `viewModels` `Element` must  conform to `Hashable`.
 
 - **DiffableContent** -
 
    - Defines the content of any data source, it has an array property that represents the sections in a data source.
    `sections` `Element` must  conform to `Hashable`.
 
 This class needs to models that conform to these 2 protocols, and need to be specified as a generic constraint.
 
    * Go to the bottom of the file to see an example..*.
 */

@available(iOS 13, *)
final class GenericContainerDiffableCollectionView<Content: DiffableContent,
                                                   Section: DiffableSection,
                                                   CellType: BaseCollectionViewCell<Section.DiffableViewModel>>: BaseXibView, UICollectionViewDelegate {
    
    override var customXibIdentifier: String? { "GenericContainerDiffableCollectionView" }
    
    // MARK:- UI
    @IBOutlet private var collectionView: UICollectionView! {
        didSet {
            collectionView.register(CellType.self)
        }
    }

    // MARK:- Type Aliases
    typealias SectionViewModelIdentifier = Content.DiffableSectionViewModel // represents a section
    typealias CellViewModelIdentifier = Content.DiffableSectionViewModel.DiffableViewModel // represents an item in a section
    
    private typealias DiffDataSource = UICollectionViewDiffableDataSource<SectionViewModelIdentifier, CellViewModelIdentifier>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<SectionViewModelIdentifier, CellViewModelIdentifier>
    
    typealias SelectedContentAtIndexPath = ((CellViewModelIdentifier, IndexPath) -> Void)
    var selectedContentAtIndexPath: SelectedContentAtIndexPath?
    
    // MARK:- Diffable Data Source
    private var dataSource: DiffDataSource?
    private var currentSnapshot: Snapshot?
    
    private weak var parent: UIViewController?
    
    // MARK:- Life Cycle
    convenience init(layout: UICollectionViewLayout, parent: UIViewController?) {
        self.init()
        collectionView?.collectionViewLayout = layout
        configureDataSource()
        self.parent = parent
    }
    
    // MARK:- 1: DataSource Configuration
    private func configureDataSource() {
        dataSource = DiffDataSource(collectionView: collectionView) { collectionView, indexPath, model in
            let cell: CellType = collectionView.dequeueReusableCell(forIndexPath: indexPath)
            cell.setupWith(model as! Section.DiffableViewModel, parent: self.parent)
            return cell
        }
    }
    
    // MARK:- 2: ViewModels injection and snapshot
    func applySnapshotWith(_ sections: [SectionViewModelIdentifier]) {
        let content = Content(sections: sections)
        currentSnapshot = Snapshot()
        currentSnapshot?.appendSections(content.sections)
        content.sections.forEach {
            currentSnapshot?.appendItems($0.viewModels, toSection: $0)
        }
        dataSource?.apply(currentSnapshot!)
    }
    
    // MARK:- UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let viewModel = dataSource?.itemIdentifier(for: indexPath) else { return }
        selectedContentAtIndexPath?(viewModel, indexPath)
    }
}
