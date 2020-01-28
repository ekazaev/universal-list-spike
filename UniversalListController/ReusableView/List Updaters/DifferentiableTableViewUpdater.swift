//
// DifferentiableTableViewUpdater.swift
// UniversalListController
//

import DifferenceKit
import Foundation
import UIKit

class DifferentiableTableViewUpdater<CellContext>: ReusableViewListUpdater, TableViewConfigurable
    where
    CellContext: CellSource,
    CellContext: Differentiable,
    CellContext.Cell: UITableViewCell {

    private let dataSource: TableViewDataSource<Void, CellContext>

    private var tableView: UITableView?

    init(dataSource: TableViewDataSource<Void, CellContext>) {
        self.dataSource = dataSource
    }

    func update(with data: ListData<Void, CellContext>) {
        let source = dataSource.data.getAsDifferentiableArray()
        let target = data.getAsDifferentiableArray()
        let changeSet = StagedChangeset(source: source, target: target)
        tableView?.reload(using: changeSet, with: .fade) { data in
            let sections = data.map { SectionData(cells: $0.elements.map { CellData(context: $0) }) }
            dataSource.data = ListData(sections: sections)
        }
    }

    func setup(for tableView: UITableView) {
        self.tableView = tableView
        dataSource.setup(for: tableView)
        tableView.dataSource = dataSource
    }
}
