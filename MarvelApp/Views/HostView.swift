//
//  HostView.swift
//  MarvelApp
//
//  Created by James Rochabrun on 12/7/20.
//

import UIKit
import SwiftUI

final class HostView<V: View>: UIView {
    
    private weak var controller: UIHostingController<V>?
    
    init(parent: UIViewController, view: V) {
        super.init(frame: .zero)
        host(view, in: parent)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func host(_ view: V, in parent: UIViewController) {
    
        defer { controller?.view.invalidateIntrinsicContentSize() }
        
        if let controller = controller {
            controller.rootView = view
        } else {
            let hostingController = UIHostingController(rootView: view)
            controller = hostingController
            parent.addChild(hostingController)
            hostingController.view.translatesAutoresizingMaskIntoConstraints = false
            addSubview(hostingController.view)
            NSLayoutConstraint.activate([
                hostingController.view.leadingAnchor.constraint(equalTo: leadingAnchor),
                hostingController.view.topAnchor.constraint(equalTo: topAnchor),
                hostingController.view.trailingAnchor.constraint(equalTo: trailingAnchor),
                hostingController.view.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
            hostingController.didMove(toParent: parent)
        }
    }
}
