//
// GlobalSearchBuilder.swift
// UniversalListController
//

import CustomTabViewController
import Foundation
import UIKit

struct GlobalSearchBuilder {

    func build() -> UIViewController {
        let searchContainerController = SearchBarContainerViewController()

        let citiesSearchViewController = GenericSearchBuilder<CityTableCell, PaginatingDataProvider<CityDataProvider, City>>(dataProvider: PaginatingDataProvider(for: CityDataProvider(), itemsPerPage: 5)).build()
        let personSearchViewController = GenericSearchBuilder<PersonTableCell, PaginatingDataProvider<PeopleDataProvider, Person>>(dataProvider: PaginatingDataProvider(for: PeopleDataProvider(), itemsPerPage: 20)).build()

        citiesSearchViewController.title = "Cities"
        personSearchViewController.title = "Peoples"

        searchContainerController.searchBarController.add(delegate: citiesSearchViewController)
        searchContainerController.searchBarController.add(delegate: personSearchViewController)

        // Custom tab Bar
        let tabBarController = CustomTabViewController(nibName: "CustomTabViewController",
                                                       bundle: Bundle(for: CustomTabViewController.self))
        tabBarController.viewControllers = [
            citiesSearchViewController,
            personSearchViewController
        ]

        searchContainerController.containingViewController = tabBarController

        searchContainerController.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        searchContainerController.tabBarItem.title = "Search"
        return searchContainerController
    }

}
