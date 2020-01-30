//
// TableViewUpdater.swift
// UniversalListController
//

import Foundation
import UIKit

final class TableViewUpdater<SectionContext, CellContext, Source: ViewSource>: ReusableViewListUpdater
    where
    Source.View: UITableView,
    CellContext: CellSource,
    CellContext.Cell: UITableViewCell {

    private let dataSource: TableViewDataSource<SectionContext, CellContext, Source>

    private let viewSource: Source

    private lazy var tableView: Source.View = {
        let tableView = viewSource.view
        tableView.dataSource = dataSource
        return tableView
    }()

    init(viewSource: Source, dataSource: TableViewDataSource<SectionContext, CellContext, Source>) {
        self.dataSource = dataSource
        self.viewSource = viewSource
    }

    func update(with data: ListData<SectionContext, CellContext>) {
        dataSource.data = data
        guard viewSource.isViewLoaded else {
            return
        }
        tableView.reloadData()
    }

}
