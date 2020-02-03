//
//  SceneDelegate.swift
//  UniversalListController
//
//  Created by Eugene Kazaev on 27/01/2020.
//  Copyright © 2020 Eugene Kazaev. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.windowScene = windowScene
        let tabBarController = UITabBarController()

        // First
        let searchContainerController = SearchContainerViewController()
        let searchTableViewFactory = TableViewFactory(style: .grouped)
        let searchDataSource = TableViewDataSourceController<Void, ListStateCellAdapter<CityTableCell, LoadingTableViewCell>, TableViewFactory>(holder: searchTableViewFactory)

        let searchViewUpdater = DifferentiableTableViewUpdater(holder: searchTableViewFactory, dataSource: searchDataSource)
        let dataProvider = CityDataProvider()
        let searchDataTransformer = ListStateDataTransformer<CityTableCell, LoadingTableViewCell>()

        let searchEventHandler = CitySearchEventHandler(viewUpdater: searchViewUpdater,
                                                        citiesProvider: PaginatingDataProvider(for: dataProvider, itemsPerPage: 5),
                                                        dataTransformer: searchDataTransformer)
        searchContainerController.searchBarController.delegate = searchEventHandler

        let nextPageRequester = DefaultScrollViewNextPageRequester(nextPageEventInset: 10, eventHandler: searchEventHandler)
        let delegateController = SimpleTableViewDelegateController(nextPageRequester: nextPageRequester, eventHandler: searchEventHandler)

        searchTableViewFactory.delegate = delegateController

        let searchTableViewController = UniversalListViewController(
            factory: searchTableViewFactory,
            eventHandler: [searchEventHandler],
            dataSourceController: searchDataSource,
            delegateController: delegateController
        )

        searchContainerController.containingViewController = searchTableViewController
        searchTableViewController.delegate = searchEventHandler

        // Second:
        let tableViewFactory = TableViewFactory(style: .grouped)
        let tableDataSource = TableViewDataSourceController<Void, ConfigurableCellAdapter<CityTableCell>, TableViewFactory>(holder: tableViewFactory)

        let viewUpdater = DifferentiableTableViewUpdater(holder: tableViewFactory, dataSource: tableDataSource)
        let tableDataTransformer = DirectDataTransformer<[[City]], CityTableCell>()

        let tableEventHandler = RandomizingEventHandler(viewUpdater: viewUpdater, dataProvider: EnclosingArrayDataProvider(for: ShufflingDataProvider(for: CityDataProvider())), dataTransformer: tableDataTransformer)
        let tableViewController = UniversalListViewController(
            factory: tableViewFactory,
            eventHandler: tableEventHandler,
            dataSourceController: tableDataSource,
            delegateController: SimpleTableViewDelegateController(eventHandler: searchEventHandler)
        )

        // Third:
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 150, height: 200)
        let collectionViewFactory = CollectionViewFactory(collectionViewLayout: layout)
        let collectionDataSource = CollectionViewDataSourceController<Void, ConfigurableCellAdapter<CityCollectionCell>, CollectionViewFactory>(holder: collectionViewFactory)

        let collectionViewUpdater = DifferentiableCollectionViewUpdater(holder: collectionViewFactory, dataSource: collectionDataSource)
        let collectionDataTransformer = DirectDataTransformer<[[City]], CityCollectionCell>()

        let collectionEventHandler = RandomizingEventHandler(viewUpdater: collectionViewUpdater, dataProvider: EnclosingArrayDataProvider(for: ShufflingDataProvider(for: CityDataProvider())), dataTransformer: collectionDataTransformer)
        let collectionViewController = UniversalListViewController(factory: collectionViewFactory,
                                                                   eventHandler: collectionEventHandler, dataSourceController: collectionDataSource,
                                                                   delegateController: SimpleCollectionViewDelegateController())

        tabBarController.viewControllers = [ /* UINavigationController(rootViewController: controller), */
            UINavigationController(rootViewController: searchContainerController),
            UINavigationController(rootViewController: tableViewController),
            UINavigationController(rootViewController: collectionViewController)
        ]
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()

    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }

}
