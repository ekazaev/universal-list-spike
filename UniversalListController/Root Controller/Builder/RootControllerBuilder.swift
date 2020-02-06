//
// AppControllerBuilder.swift
// UniversalListController
//

import Foundation
import Shared
import SharedUI
import UIKit

struct RootControllerBuilder {

    func build() -> UIViewController {
        let tabBarController = UITabBarController()

        let searchContainerController = GlobalSearchBuilder().build()
        let tableViewController = RandomizingTableDemoBuilder<PeopleDataProvider, PersonTableCell>(
            dataProvider: PeopleDataProvider(),
            tabBarConfiguration: .init(image: UIImage(systemName: "globe"), title: "Cities")
        ).build()

        let collectionViewController = RandomizingCollectionDemoBuilder<CityDataProvider, CityCollectionCell>(
            dataProvider: CityDataProvider(),
            tabBarConfiguration: .init(image: UIImage(systemName: "person"), title: "People")
        ).build()

        tabBarController.viewControllers = [
            UINavigationController(rootViewController: searchContainerController),
            UINavigationController(rootViewController: tableViewController),
            UINavigationController(rootViewController: collectionViewController)
        ]

        return tabBarController
    }

}
