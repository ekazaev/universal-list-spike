//
// SearchBarContainerViewController.swift
// UniversalListController
//

import Foundation
import UIKit

final class SearchBarContainerViewController: UIViewController {

    var containingViewController: UIViewController? {
        didSet {
            guard let containingViewController = containingViewController else {
                containerController.viewControllers = []
                return
            }
            containerController.viewControllers = [containingViewController]
        }
    }

    private lazy var containerView: UIView = setupContainerView()

    private lazy var containerController = {
        return ContainerController(for: self,
                                   containerView: self.containerView)
    }()

    private(set) var searchBarController: SearchBarController = SearchBarController()

    override func viewDidLoad() {
        super.viewDidLoad()
        containerController.setup()
        view.backgroundColor = .white

        let searchBar = UISearchBar()
        navigationItem.titleView = searchBar
        searchBar.delegate = searchBarController
    }

    private func setupContainerView() -> UIView {
        let containerView = UIView(frame: view.bounds)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(containerView)
        containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        return containerView
    }

}

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
