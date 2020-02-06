//
// GlobalSearchBuilder.swift
// UniversalListController
//

import CustomTabViewController
import EntitySearch
import Foundation
import Shared
import SharedUI
import UIKit

public struct GlobalSearchBuilder<B: InstanceBuilder> where B.Input == Void, B.Output == UIViewController & SearchBarControllerDelegate {

    public struct Configuration {

        public var title: String

        public var builder: B

        public init(title: String, builder: B) {
            self.title = title
            self.builder = builder
        }
    }

    private let configuration: [Configuration]

    public init(builders: [Configuration]) {
        configuration = builders
    }

    public func build() -> UIViewController {
        let searchContainerController = SearchBarContainerViewController()

        let viewControllers = configuration.map { config -> B.Output in
            let viewController = config.builder.build()
            viewController.title = config.title
            return viewController
        }

        viewControllers.forEach {
            searchContainerController.searchBarController.add(delegate: $0)
        }

        // Custom tab Bar
        let tabBarController = CustomTabViewController(nibName: "CustomTabViewController",
                                                       bundle: Bundle(for: CustomTabViewController.self))
        tabBarController.viewControllers = viewControllers

        searchContainerController.containingViewController = tabBarController

        searchContainerController.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        searchContainerController.tabBarItem.title = "Search"
        return searchContainerController
    }

}
