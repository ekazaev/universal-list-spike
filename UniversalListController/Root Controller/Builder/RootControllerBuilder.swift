//
// AppControllerBuilder.swift
// UniversalListController
//

import EntitySearch
import Foundation
import RandomList
import Search
import Shared
import SharedUI
import UIKit

struct RootControllerBuilder {

    func build() -> UIViewController {
        let tabBarController = UITabBarController()
        let searchViewController = buildSearchController()

        let randomTableController = RandomizingTableDemoBuilder<PeopleDataProvider, PersonTableCell>(
            dataProvider: PeopleDataProvider(),
            tabBarConfiguration: .init(image: UIImage(systemName: "person"), title: "People")
        ).build()

        let randomCollectionController = RandomizingCollectionDemoBuilder<CityDataProvider, CityCollectionCell>(
            dataProvider: CityDataProvider(),
            tabBarConfiguration: .init(image: UIImage(systemName: "globe"), title: "Cities")
        ).build()

        tabBarController.viewControllers = [
            UINavigationController(rootViewController: searchViewController),
            UINavigationController(rootViewController: randomTableController),
            UINavigationController(rootViewController: randomCollectionController)
        ]

        return tabBarController
    }

    private func buildSearchController() -> UIViewController {
        let citySearchBuilder = GenericSearchBuilder<CityTableCell, PaginatingDataProvider<CityDataProvider, City>>(dataProvider: PaginatingDataProvider(for: CityDataProvider(), itemsPerPage: 5))
        let peopleSearchBuilder = GenericSearchBuilder<PersonTableCell, PaginatingDataProvider<PeopleDataProvider, Person>>(dataProvider: PaginatingDataProvider(for: PeopleDataProvider(), itemsPerPage: 20))
        let builders = [
            GlobalSearchBuilder.Configuration(title: "Cities", builder: AnyBuilder(with: citySearchBuilder)),
            GlobalSearchBuilder.Configuration(title: "People", builder: AnyBuilder(with: peopleSearchBuilder))
        ]

        let searchViewController = GlobalSearchBuilder(builders: builders).build()
        return searchViewController
    }

}
