//
// RandomizingDemoBuilder.swift
// UniversalListController
//

import Foundation
import UIKit
import ReusableView
import UniversalListViewController
import DifferenceKit

struct RandomizingTableDemoBuilder<DP: DataProvider, Cell: UITableViewCell & ConfigurableReusableView>
    where
    DP.Request == String,
    Cell.Data: Differentiable,
    [Cell.Data] == DP.Data {

    private let dataProvider: DP

    init(dataProvider: DP) {
        self.dataProvider = dataProvider
    }

    func build() -> UIViewController {
        let tableViewFactory = TableViewFactory(style: .grouped)
        let tableDataSource = TableViewDataSourceController<Void, ConfigurableCellAdapter<Cell>, TableViewFactory>(holder: tableViewFactory)

        let viewUpdater = DifferentiableTableViewUpdater(holder: tableViewFactory, dataSource: tableDataSource)
        let tableDataTransformer = ConfigurableDataTransformer<[[Cell.Data]], Cell>()

        let tableEventHandler = RandomizingEventHandler(
            viewUpdater: viewUpdater,
            dataProvider: EnclosingArrayDataProvider(for: ShufflingDataProvider(for: dataProvider)),
            dataTransformer: tableDataTransformer)

        let tableViewController = UniversalListViewController(
            view: tableViewFactory.build(),
            dataSourceController: tableDataSource,
            delegateController: SimpleTableViewDelegateController()
        )
        tableViewController.eventHandler = tableEventHandler

        return tableViewController
    }

}
