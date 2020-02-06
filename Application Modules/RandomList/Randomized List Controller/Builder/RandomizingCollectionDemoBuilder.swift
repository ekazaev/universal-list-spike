//
// RandomizingCollectionDemoBuilder.swift
// UniversalListController
//

import DifferenceKit
import Foundation
import ReusableView
import Shared
import UIKit
import UniversalList

public class RandomizingCollectionDemoBuilder<DP: DataProvider, Cell: UICollectionViewCell & ConfigurableReusableView>
    where
    DP.Request == String,
    Cell.Data: Differentiable,
    [Cell.Data] == DP.Data {

    private let dataProvider: DP
    private let tabBarConfiguration: TabBarConfiguration

    public init(dataProvider: DP, tabBarConfiguration: TabBarConfiguration) {
        self.dataProvider = dataProvider
        self.tabBarConfiguration = tabBarConfiguration
    }

    public func build() -> UIViewController {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 150, height: 200)
        let collectionViewFactory = CollectionViewFactory(collectionViewLayout: layout)
        let collectionDataSource = CollectionViewDataSourceController<Void, ConfigurableCellAdapter<Cell>, CollectionViewFactory>(viewProxy: collectionViewFactory)

        let collectionViewUpdater = DifferentiableCollectionViewUpdater(viewProxy: collectionViewFactory, dataSource: collectionDataSource)
        let collectionDataTransformer = ConfigurableDataTransformer<[[Cell.Data]], Cell>()

        collectionViewFactory.dataSource = collectionDataSource

        let collectionEventHandler = RandomizingEventHandler(viewUpdater: collectionViewUpdater, dataProvider: EnclosingArrayDataProvider(for: ShufflingDataProvider(for: dataProvider)), dataTransformer: collectionDataTransformer)
        let collectionViewController = UniversalListViewController(
            view: collectionViewFactory.build(),
            eventHandler: collectionEventHandler,
            dataSourceController: collectionDataSource,
            delegateController: SimpleCollectionViewDelegateController()
        )

        collectionViewController.tabBarItem.image = tabBarConfiguration.image
        collectionViewController.tabBarItem.title = tabBarConfiguration.title

        return collectionViewController
    }

}
