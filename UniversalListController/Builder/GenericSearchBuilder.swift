//
// Created by Eugene Kazaev on 03/02/2020.
// Copyright (c) 2020 Eugene Kazaev. All rights reserved.
//

import DifferenceKit
import Foundation
import ReusableView
import UIKit
import UniversalList

struct GenericSearchBuilder<DataCell: ConfigurableReusableView,
                            DP: PageableDataProvider>
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

    func build() -> UIViewController & SearchBarControllerDelegate {
        let searchTableViewFactory = TableViewFactory(style: .grouped)
        let searchDataSource = TableViewDataSourceController<Void, ListStateCellAdapter<DataCell, LoadingTableViewCell>, TableViewFactory>(holder: searchTableViewFactory)

        let searchViewUpdater = DifferentiableTableViewUpdater(holder: searchTableViewFactory, dataSource: searchDataSource)
        let searchDataTransformer = ListStateDataTransformer<DataCell, LoadingTableViewCell>()

        let searchEventHandler = GenericSearchEventHandler(viewUpdater: searchViewUpdater,
                                                           citiesProvider: dataProvider,
                                                           dataTransformer: searchDataTransformer)

        let nextPageRequester = DefaultScrollViewNextPageRequester(nextPageEventInset: 10,
                                                                   nextPageEventHandler: searchEventHandler,
                                                                   loadingStateEventHandler: searchEventHandler)
        let delegateController = SimpleTableViewDelegateController(nextPageRequester: nextPageRequester, eventHandler: searchEventHandler)

        searchTableViewFactory.delegate = delegateController

        let searchTableViewController = UniversalListViewController(
            view: searchTableViewFactory.view,
            dataSourceController: searchDataSource,
            delegateController: delegateController
        )
        // Fix
        searchTableViewController.eventHandler = searchEventHandler

        let containerController = SearchResultsContainerViewController(eventHandler: searchEventHandler)

        let initialViewController = UIViewController(nibName: "StartTypingViewController", bundle: nil)
        let noResultsViewController = UIViewController(nibName: "NoResultsAvailableViewController", bundle: nil)
        containerController.viewControllers = [initialViewController, searchTableViewController, noResultsViewController]

        searchEventHandler.delegate = containerController

        return containerController
    }

}
