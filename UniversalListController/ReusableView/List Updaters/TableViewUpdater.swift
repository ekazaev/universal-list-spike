//
// TableViewUpdater.swift
// UniversalListController
//

import Foundation
import UIKit

class TableViewUpdater<SectionContext, CellContext, VS: ViewSource>: ReusableViewListUpdater
    where
    VS.View: UITableView,
    CellContext: CellSource,
    CellContext.Cell: UITableViewCell {

    private let dataSource: TableViewDataSource<SectionContext, CellContext, VS>

    private let viewSource: VS

    private lazy var tableView: VS.View = {
        let tableView = viewSource.view
        tableView.dataSource = dataSource
        return tableView
    }()

    init(viewSource: VS, dataSource: TableViewDataSource<SectionContext, CellContext, VS>) {
        self.dataSource = dataSource
        self.viewSource = viewSource
    }

    func update(with data: ListData<SectionContext, CellContext>) {
        dataSource.data = data
        tableView.reloadData()
    }

}
