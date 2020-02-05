//
// TableViewUpdater.swift
// UniversalListController
//

import Foundation
import ReusableView
import UIKit

public final class TableViewUpdater<DataSource: UniversalListDataSourceController & UITableViewDataSource, ListHolder: ViewHolder>: UniversalListUpdater
    where
    ListHolder.View: UITableView,
    DataSource.View: UITableView,
    DataSource.CellContext: CellAdapter,
    DataSource.CellContext.Cell: UITableViewCell {

    private weak var dataSource: DataSource?

    private let holder: ListHolder

    private lazy var tableView: ListHolder.View = {
        let tableView = holder.view
        tableView.dataSource = dataSource
        return tableView
    }()

    public init(holder: ListHolder, dataSource: DataSource) {
        self.dataSource = dataSource
        self.holder = holder
    }

    public func update(with data: ListData<DataSource.SectionContext, DataSource.CellContext>) {
        guard let dataSource = dataSource else {
            return
        }
        dataSource.data = data
        guard holder.isViewLoaded else {
            return
        }
        tableView.reloadData()
    }

}
