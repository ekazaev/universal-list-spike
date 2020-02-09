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

public struct GenericSearchBuilder<DataCell: ConfigurableReusableView, DP: PageableDataProvider>: InstanceBuilder
    where
    DataCell: UITableViewCell,
    DataCell.Data: Identifiable & Differentiable,
    DP.Data == [DataCell.Data],
    DP.Request == String {

    private let dataProvider: DP

    public init(dataProvider: DP) {
        self.dataProvider = dataProvider
    }

    public func build(with _: Void) -> UIViewController & SearchBarControllerDelegate {
        let viewFactory = TableViewFactory(style: .grouped)

        let dataTransformer = ListStateDataTransformer<ConfigurableCellAdapter<DataCell>, LoadingAccessoryTableCellAdapter>()

        let dataSource = TableViewDataSourceController(viewProxy: viewFactory, usingWith: dataTransformer)

        let viewUpdater = DifferentiableTableViewUpdater(viewProxy: viewFactory, dataSource: dataSource)

        let eventHandler = GenericSearchEventHandler(viewUpdater: viewUpdater,
                                                     citiesProvider: dataProvider,
                                                     dataTransformer: dataTransformer)

        let nextPageRequester = DefaultScrollViewNextPageRequester(nextPageEventInset: 10,
                                                                   nextPageEventHandler: eventHandler,
                                                                   loadingStateSource: eventHandler)

        let delegateController = UITableViewDelegateSplitter(tableViewDelegate: SimpleTableViewDelegateController(eventHandler: eventHandler),
                                                             scrollViewDelegate: nextPageRequester)

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

        eventHandler.resultDelegate = containerController

        return containerController
    }

}
