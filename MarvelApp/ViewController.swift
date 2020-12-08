//
//  ViewController.swift
//  MarvelApp
//
//  Created by James Rochabrun on 12/6/20.
//

import UIKit
import CommonCrypto
import Combine

class ViewController: UIViewController {

    let provider = MarvelProvider()
    private var cancellables: Set<AnyCancellable> = []

    var hostView: HostView<CarachterArtworkView>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        provider.$characters.sink { [unowned self] characters in
            
            guard !characters.isEmpty else { return }
            let artworkSwiftUIVIew = CarachterArtworkView(artworkViewModel: characters.first!.artwork!, variant: .detail)
            hostView = HostView(parent: self, view: artworkSwiftUIVIew)
            view.addSubview(hostView!)
            hostView?.fill()
        }.store(in: &cancellables)
      
    }
}


extension String {
    func md5() -> String {
        let data = Data(utf8)
        var hash = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))

        data.withUnsafeBytes { buffer in
            _ = CC_MD5(buffer.baseAddress, CC_LONG(buffer.count), &hash)
        }

        return hash.map { String(format: "%02hhx", $0) }.joined()
    }
}

extension UIView {
    
    func fill() {
        translatesAutoresizingMaskIntoConstraints = false
        guard let superView = superview else { fatalError() }
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: superView.leadingAnchor),
            topAnchor.constraint(equalTo: superView.topAnchor),
            trailingAnchor.constraint(equalTo: superView.trailingAnchor),
            bottomAnchor.constraint(equalTo: superView.bottomAnchor)
        ])
    }
}
