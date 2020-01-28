//
// DifferentiableTableViewUpdater.swift
// UniversalListController
//

import DifferenceKit
import Foundation
import UIKit

class DifferentiableTableViewUpdater<CellContext>: ReusableViewListUpdater
    where
    CellContext: CellSource,
    CellContext: Differentiable,
    CellContext.Cell: UITableViewCell {

    private let dataSource: TableViewDataSource<Void, CellContext>

    private let tableView: UITableView

    init<VP: ListViewProvider>(viewProvider: VP, dataSource: TableViewDataSource<Void, CellContext>) where VP.ListView: UITableView {
        self.dataSource = dataSource
        tableView = viewProvider.listView
    }

    func update(with data: ListData<Void, CellContext>) {
        let source = dataSource.data.getAsDifferentiableArray()
        let target = data.getAsDifferentiableArray()
        let changeSet = StagedChangeset(source: source, target: target)
        tableView.reload(using: changeSet, with: .fade) { data in
            let sections = data.map { SectionData(cells: $0.elements.map { CellData(context: $0) }) }
            dataSource.data = ListData(sections: sections)
        }
    }

}
