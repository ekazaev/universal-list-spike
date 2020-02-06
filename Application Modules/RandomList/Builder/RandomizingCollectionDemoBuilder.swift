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
        let viewFactory = CollectionViewFactory(collectionViewLayout: layout)
        let dataSource = CollectionViewDataSourceController<Void, ConfigurableCellAdapter<Cell>, CollectionViewFactory>(viewProxy: viewFactory)

        let viewUpdater = DifferentiableCollectionViewUpdater(viewProxy: viewFactory, dataSource: dataSource)
        let dataTransformer = ConfigurableDataTransformer<[[Cell.Data]], Cell>()

        viewFactory.dataSource = dataSource

        let eventHandler = RandomizingEventHandler(
            viewUpdater: viewUpdater,
            dataProvider: EnclosingArrayDataProvider(for: ShufflingDataProvider(for: dataProvider)),
            dataTransformer: dataTransformer
        )

        let viewController = UniversalListViewController(
            view: viewFactory.build(),
            eventHandler: eventHandler,
            dataSourceController: dataSource,
            delegateController: SimpleCollectionViewDelegateController()
        )

        viewController.tabBarItem.image = tabBarConfiguration.image
        viewController.tabBarItem.title = tabBarConfiguration.title

        return viewController
    }

}
