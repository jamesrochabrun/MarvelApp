//
//  BaseXibView.swift
//  MarvelApp
//
//  Created by James Rochabrun on 12/8/20.
//

import UIKit

class BaseXibView: UIView {
    
    /// Override  this property when your xib file in the bundle does not match the syntax  of your class.
    /// Most likely if you use this class with generic constraints.
    var customXibIdentifier: String? { nil }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupXib()
        setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupXib()
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        setUpViews()
    }
    
    // To be overriden. Super does not need to be called.
    func setUpViews() {
    }
}


extension BaseXibView {
    
    fileprivate func setupXib() {
        
        guard let view = self.loadView() else {
            return
        }
        view.frame = self.bounds
        view.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        self.addSubview(view)
        
    }
    
    private func loadView() -> UIView? {
        guard
            let nibName = customXibIdentifier ??
                NSStringFromClass(type(of: self)).components(separatedBy: ".").last
        else {
                return nil
        }
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as? UIView
        return view
    }
}

