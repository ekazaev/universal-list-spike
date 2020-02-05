//
// UIViewController+Children.swift
// UniversalListController
//

import Foundation
import UIKit

extension UIViewController {

    func add(child: UIViewController, within containerView: UIView? = nil) {
        let isAlreadyChild = children.contains(child)
        if isAlreadyChild {
            child.willMove(toParent: self)
        }
        if let containerView = containerView {
            child.view.translatesAutoresizingMaskIntoConstraints = false
            containerView.addSubview(child.view)
            child.view.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
            child.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
            child.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
            child.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        }
        if isAlreadyChild {
            child.didMove(toParent: self)
        }
    }

    func remove(child: UIViewController) {
        child.willMove(toParent: nil)
        child.view.removeFromSuperview()
        child.removeFromParent()
        child.didMove(toParent: nil)
    }

}
