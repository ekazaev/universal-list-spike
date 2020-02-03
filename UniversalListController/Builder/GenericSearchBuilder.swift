//
// Created by Eugene Kazaev on 03/02/2020.
// Copyright (c) 2020 Eugene Kazaev. All rights reserved.
//

import DifferenceKit
import Foundation
import UIKit

struct GenericSearchBuilder<DataCell: ConfigurableReusableView,
                            DP: DataProvider>
    where
    DataCell: UITableViewCell,
    DataCell.Data: Identifiable & Differentiable,
    DataCell.Data.DifferenceIdentifier == Int,
    DP.Data == [DataCell.Data],
    DP.Request == String {

    private let dataProvider: DP

    init(dataProvider: DP) {
        self.dataProvider = dataProvider
    }

    func build() -> UIViewController {
        let searchTableViewFactory = TableViewFactory(style: .grouped)
        let searchDataSource = TableViewDataSourceController<Void, ListStateCellAdapter<DataCell, LoadingTableViewCell>, TableViewFactory>(holder: searchTableViewFactory)

        let searchViewUpdater = DifferentiableTableViewUpdater(holder: searchTableViewFactory, dataSource: searchDataSource)
        let searchDataTransformer = ListStateDataTransformer<DataCell, LoadingTableViewCell>()

        let searchEventHandler = GenericSearchEventHandler(viewUpdater: searchViewUpdater,
                                                           citiesProvider: PaginatingDataProvider(for: dataProvider, itemsPerPage: 5),
                                                           dataTransformer: searchDataTransformer)

        let nextPageRequester = DefaultScrollViewNextPageRequester(nextPageEventInset: 10,
                                                                   nextPageEventHandler: searchEventHandler,
                                                                   loadingStateEventHandler: searchEventHandler)
        let delegateController = SimpleTableViewDelegateController(nextPageRequester: nextPageRequester, eventHandler: searchEventHandler)

        searchTableViewFactory.delegate = delegateController

        let searchTableViewController = UniversalListViewController(
            factory: searchTableViewFactory,
            dataSourceController: searchDataSource,
            delegateController: delegateController
        )
        searchTableViewController.title = "Cities"
        searchTableViewController.eventHandler = searchEventHandler
        return searchTableViewController
    }

}
