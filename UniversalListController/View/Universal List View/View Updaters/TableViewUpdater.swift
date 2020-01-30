//
// TableViewUpdater.swift
// UniversalListController
//

import Foundation
import UIKit

final class TableViewUpdater<DataSource: ReusableViewListDataSource & UITableViewDataSource, ViewSource: ListViewSource>: ReusableViewListUpdater
    where
    ViewSource.View: UITableView,
    DataSource.View: UITableView,
    DataSource.CellContext: CellSource,
    DataSource.CellContext.Cell: UITableViewCell {

    private var dataSource: DataSource

    private let viewSource: ViewSource

    private lazy var tableView: ViewSource.View = {
        let tableView = viewSource.view
        tableView.dataSource = dataSource
        return tableView
    }()

    init(viewSource: ViewSource, dataSource: DataSource) {
        self.dataSource = dataSource
        self.viewSource = viewSource
    }

    func update(with data: ListData<DataSource.SectionContext, DataSource.CellContext>) {
        dataSource.data = data
        guard viewSource.isViewLoaded else {
            return
        }
        tableView.reloadData()
    }

}
