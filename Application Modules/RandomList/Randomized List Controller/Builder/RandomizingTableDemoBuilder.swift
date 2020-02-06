//
// RandomizingDemoBuilder.swift
// UniversalListController
//

import DifferenceKit
import Foundation
import ReusableView
import Shared
import UIKit
import UniversalListViewController

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
        let tableViewFactory = TableViewFactory(style: .grouped)
        let tableDataSource = TableViewDataSourceController<Void, ConfigurableCellAdapter<Cell>, TableViewFactory>(viewProxy: tableViewFactory)

        let viewUpdater = DifferentiableTableViewUpdater(viewProxy: tableViewFactory, dataSource: tableDataSource)
        let tableDataTransformer = ConfigurableDataTransformer<[[Cell.Data]], Cell>()

        let tableEventHandler = RandomizingEventHandler(
            viewUpdater: viewUpdater,
            dataProvider: EnclosingArrayDataProvider(for: ShufflingDataProvider(for: dataProvider)),
            dataTransformer: tableDataTransformer
        )

        tableViewFactory.dataSource = tableDataSource

        let tableViewController = UniversalListViewController(
            view: tableViewFactory.build(),
            eventHandler: tableEventHandler,
            dataSourceController: tableDataSource,
            delegateController: SimpleTableViewDelegateController()
        )

        tableViewController.tabBarItem.image = tabBarConfiguration.image
        tableViewController.tabBarItem.title = tabBarConfiguration.title

        return tableViewController
    }

}
