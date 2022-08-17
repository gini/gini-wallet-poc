//
//  UIViewController+Embed.swift
//  Core
//
//  Created by Botond Magyarosi on 05/02/2021.
//

import UIKit

public extension UIViewController {

    /// Embeds a child controller inside `self.view`.
    /// - Parameter child: child controller to embed inside.
    func embed(_ child: UIViewController) {
        embed(child, inView: view)
    }

    /// Embed a child controller inside any subview of `self.view` (including).
    /// - Parameters:
    ///   - child: child controller to embed inside.
    ///   - parentView: a child view (including self.view) to embed in.
    func embed(_ child: UIViewController, inView parentView: UIView) {
        assert(parentView.isDescendant(of: view), "inView must be a subview of self.")

        addChild(child)
        child.view.translatesAutoresizingMaskIntoConstraints = false
        parentView.addSubview(child.view)
        NSLayoutConstraint.activate([
            child.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            child.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            child.view.topAnchor.constraint(equalTo: view.topAnchor),
            child.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        child.didMove(toParent: self)
    }

    /// Un-embed controller from its parent.
    func unEmbed() {
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
}
