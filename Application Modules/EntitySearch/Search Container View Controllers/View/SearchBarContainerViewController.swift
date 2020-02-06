//
// SearchBarContainerViewController.swift
// UniversalListController
//

import Core
import Foundation
import SharedUI
import UIKit

public final class SearchBarContainerViewController: UIViewController {

    public var containingViewController: UIViewController? {
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

    public private(set) var searchBarController: SearchBarController = SearchBarController()

    public override func viewDidLoad() {
        super.viewDidLoad()
        containerController.setup()
        view.backgroundColor = .white

        let searchBar = UISearchBar()
        navigationItem.titleView = searchBar
        searchBar.delegate = searchBarController
    }

    private func setupContainerView() -> UIView {
        let containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        containerView.addConstraints(equalToSuperview())
        return containerView
    }

}
