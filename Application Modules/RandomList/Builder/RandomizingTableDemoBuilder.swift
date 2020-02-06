//
// RandomizingDemoBuilder.swift
// UniversalListController
//

import DifferenceKit
import Foundation
import ReusableView
import Shared
import UIKit
import UniversalList

public struct RandomizingTableDemoBuilder<DP: DataProvider, Cell: UITableViewCell & ConfigurableReusableView>
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
        let viewFactory = TableViewFactory(style: .grouped)
        let dataSource = TableViewDataSourceController<Void, ConfigurableCellAdapter<Cell>, TableViewFactory>(viewProxy: viewFactory)

        let viewUpdater = DifferentiableTableViewUpdater(viewProxy: viewFactory, dataSource: dataSource)
        let dataTransformer = ConfigurableDataTransformer<[[Cell.Data]], Cell>()

        let tableEventHandler = RandomizingEventHandler(
            viewUpdater: viewUpdater,
            dataProvider: EnclosingArrayDataProvider(for: ShufflingDataProvider(for: dataProvider)),
            dataTransformer: dataTransformer
        )

        viewFactory.dataSource = dataSource

        let viewController = UniversalListViewController(
            view: viewFactory.build(),
            eventHandler: tableEventHandler,
            dataSourceController: dataSource,
            delegateController: SimpleTableViewDelegateController()
        )

        viewController.tabBarItem.image = tabBarConfiguration.image
        viewController.tabBarItem.title = tabBarConfiguration.title

        return viewController
    }

}
