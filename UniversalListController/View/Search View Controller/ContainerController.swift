//
// Created by Eugene Kazaev on 03/02/2020.
// Copyright (c) 2020 Eugene Kazaev. All rights reserved.
//

import Foundation
import UIKit

final class ContainerController {

    var selectedIndex: Int = 0

    private weak var containerViewController: UIViewController?

    private weak var containerView: UIView?

    var viewControllers: [UIViewController] = [] {
        didSet {
            updateStack()
        }
    }

    private weak var currentView: UIView?

    private var delayedViewBlock: (() -> Void)?

    init(for containerViewController: UIViewController,
         containerView: @escaping @autoclosure () -> UIView? = nil) {
        self.containerViewController = containerViewController
        delayedViewBlock = { [weak self] in
            self?.containerView = containerView() ?? containerViewController.view
        }
    }

    func setup() {
        guard let delayedViewBlock = delayedViewBlock else {
            return
        }
        delayedViewBlock()
        self.delayedViewBlock = nil
        updateStack()
    }

    private func updateStack() {
        guard let containerViewController = containerViewController,
            containerViewController.isViewLoaded,
            let containerView = containerView else {
                return
        }

        containerViewController.children.filter { !viewControllers.contains($0) }.forEach {
            $0.removeFromParent()
        }
        let newSelectedIndex = selectedIndex < viewControllers.count ? selectedIndex : 0
        viewControllers.enumerated().forEach { (index, viewController: UIViewController) in
            if viewController.parent != containerViewController {
                if viewController.parent != nil {
                    assertionFailure("You provided a view controller already integrated into some parent.")
                    containerViewController.remove(child: viewController)
                }
                containerViewController.add(child: viewController)
                if index == newSelectedIndex {
                    containerViewController.add(child: viewController, within: containerView)
                    self.currentView = viewController.view
                }
            }
        }
        selectedIndex = newSelectedIndex
    }

    deinit {
        viewControllers.forEach {
            containerViewController?.remove(child: $0)
        }
    }
}
