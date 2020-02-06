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
            containerView.addSubview(child.view)
            child.view.addConstraints(equalToSuperview())
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
