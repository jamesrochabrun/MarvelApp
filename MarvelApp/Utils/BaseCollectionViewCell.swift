//
//  BaseCollectionViewCell.swift
//  MarvelApp
//
//  Created by James Rochabrun on 12/8/20.
//

import UIKit

// MARK:-  Generic Collectionview cell
class BaseCollectionViewCell<V>: UICollectionViewCell {
    
    var viewModel: V? {
        didSet {
            guard let viewModel = viewModel else { return }
            setupWith(viewModel)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupSubviews()
    }
    
    // To be overriden. Super does not need to be called.
    func setupSubviews() {
    }
    
    // To be overriden. Super does not need to be called.
    func setupWith(_ viewModel: V) {
    }
    
    /// Swift UI
    func setupWith(_ viewModel: V, parent: UIViewController?) {
        
    }
}
