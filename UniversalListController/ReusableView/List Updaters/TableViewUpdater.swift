//
// TableViewUpdater.swift
// UniversalListController
//

import Foundation
import UIKit

class TableViewUpdater<SectionContext, CellContext>: ReusableViewListUpdater, TableViewConfigurable
    where
    CellContext: CellSource,
    CellContext.Cell: UITableViewCell {

    private let dataSource: TableViewDataSource<SectionContext, CellContext>

    private var tableView: UITableView?

    init(dataSource: TableViewDataSource<SectionContext, CellContext>) {
        self.dataSource = dataSource
    }

    func update(with data: ListData<SectionContext, CellContext>) {
        dataSource.data = data
        tableView?.reloadData()
    }

    func setup(for tableView: UITableView) {
        self.tableView = tableView
        dataSource.setup(for: tableView)
    }
}
