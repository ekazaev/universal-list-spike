//
// TableViewUpdater.swift
// UniversalListController
//

import Foundation
import UIKit

class TableViewUpdater<SectionContext, CellContext>: ReusableViewListUpdater
    where
    CellContext: CellSource,
    CellContext.Cell: UITableViewCell {

    private let dataSource: TableViewDataSource<SectionContext, CellContext>

    private let tableView: UITableView

    init<VP: ListViewProvider>(viewProvider: VP, dataSource: TableViewDataSource<SectionContext, CellContext>) where VP.ListView: UITableView {
        self.dataSource = dataSource
        tableView = viewProvider.listView
    }

    func update(with data: ListData<SectionContext, CellContext>) {
        dataSource.data = data
        tableView.reloadData()
    }

}
