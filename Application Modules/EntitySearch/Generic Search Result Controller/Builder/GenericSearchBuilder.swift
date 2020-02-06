//
// Created by Eugene Kazaev on 03/02/2020.
// Copyright (c) 2020 Eugene Kazaev. All rights reserved.
//

import DifferenceKit
import Foundation
import ReusableView
import Shared
import SharedUI
import UIKit
import UniversalList
import UniversalListViewController

public struct GenericSearchBuilder<DataCell: ConfigurableReusableView,
                                   DP: PageableDataProvider>
    where
    DataCell: UITableViewCell,
    DataCell.Data: Identifiable & Differentiable,
    DataCell.Data.DifferenceIdentifier == Int,
    DP.Data == [DataCell.Data],
    DP.Request == String {

    private let dataProvider: DP

    public init(dataProvider: DP) {
        self.dataProvider = dataProvider
    }

    public func build() -> UIViewController & SearchBarControllerDelegate {
        let viewFactory = TableViewFactory(style: .grouped)
        let dataSource = TableViewDataSourceController<Void, ListStateCellAdapter<DataCell, LoadingTableViewCell>, TableViewFactory>(viewProxy: viewFactory)

        let viewUpdater = DifferentiableTableViewUpdater(viewProxy: viewFactory, dataSource: dataSource)
        let dataTransformer = ListStateDataTransformer<DataCell, LoadingTableViewCell>()

        let eventHandler = GenericSearchEventHandler(viewUpdater: viewUpdater,
                                                     citiesProvider: dataProvider,
                                                     dataTransformer: dataTransformer)

        let nextPageRequester = DefaultScrollViewNextPageRequester(nextPageEventInset: 10,
                                                                   nextPageEventHandler: eventHandler,
                                                                   loadingStateEventHandler: eventHandler)

        let delegateController = SimpleTableViewDelegateController(nextPageRequester: nextPageRequester, eventHandler: eventHandler)

        viewFactory.delegate = delegateController
        viewFactory.dataSource = dataSource

        let searchTableViewController = UniversalListViewController(
            view: viewFactory.build(),
            eventHandler: eventHandler,
            dataSourceController: dataSource,
            delegateController: delegateController
        )

        // Container Controller
        let containerController = SearchResultsContainerViewController(eventHandler: eventHandler)

        let initialViewController = UIViewController(nibName: "StartTypingViewController", bundle: Bundle(for: SearchBarContainerViewController.self))
        let noResultsViewController = UIViewController(nibName: "NoResultsAvailableViewController", bundle: Bundle(for: SearchBarContainerViewController.self))
        containerController.viewControllers = [initialViewController, searchTableViewController, noResultsViewController]

        eventHandler.delegate = containerController

        return containerController
    }

}
