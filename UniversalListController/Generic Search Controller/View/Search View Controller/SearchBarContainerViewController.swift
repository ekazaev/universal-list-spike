//
// SearchBarContainerViewController.swift
// UniversalListController
//

import Core
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
