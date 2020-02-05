//
// TableViewUpdater.swift
// UniversalListController
//

import Foundation
import ReusableView
import UIKit
import UniversalList

public final class TableViewUpdater<DataSource: UniversalListDataSourceController & UITableViewDataSource, Proxy: ViewAccessProxy>: UniversalListUpdater
    where
    Proxy.View: UITableView,
    DataSource.View: UITableView,
    DataSource.CellContext: CellAdapter,
    DataSource.CellContext.Cell: UITableViewCell {

    private weak var dataSource: DataSource?

    private let viewProxy: Proxy

    private lazy var tableView: Proxy.View = {
        let tableView = viewProxy.view
        tableView.dataSource = dataSource
        return tableView
    }()

    public init(viewProxy: Proxy, dataSource: DataSource) {
        self.dataSource = dataSource
        self.viewProxy = viewProxy
    }

    public func update(with data: ListData<DataSource.SectionContext, DataSource.CellContext>) {
        guard let dataSource = dataSource else {
            return
        }
        dataSource.data = data
        guard viewProxy.isViewLoaded else {
            return
        }
        tableView.reloadData()
    }

}
