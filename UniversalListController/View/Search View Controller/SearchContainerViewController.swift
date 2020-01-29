//
// SearchContainerViewController.swift
// UniversalListController
//

import Foundation
import UIKit

class SearchContainerViewController: UIViewController {

    var containingViewController: UIViewController? {
        didSet {
            guard isViewLoaded else {
                return
            }
            setup(containingViewController: containingViewController)
        }
    }

    private var containerView: UIView!

    private(set) var searchBarController: SearchBarController = SearchBarController()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        let searchBar = UISearchBar()
        navigationItem.titleView = searchBar
        searchBar.delegate = searchBarController
        setupContainerView()
        setup(containingViewController: containingViewController)
    }

    private func setup(containingViewController: UIViewController?) {
        if let currentViewController = self.containingViewController {
            currentViewController.willMove(toParent: nil)
            currentViewController.view.removeFromSuperview()
            currentViewController.removeFromParent()
            currentViewController.didMove(toParent: nil)
        }
        if let containingViewController = containingViewController {
            containingViewController.willMove(toParent: self)
            containingViewController.view.translatesAutoresizingMaskIntoConstraints = false
            containerView.addSubview(containingViewController.view)
            containingViewController.view.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
            containingViewController.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
            containingViewController.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
            containingViewController.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
            containingViewController.didMove(toParent: self)
        }
    }

    private func setupContainerView() {
        containerView = UIView(frame: view.bounds)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(containerView)
        containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }

}
