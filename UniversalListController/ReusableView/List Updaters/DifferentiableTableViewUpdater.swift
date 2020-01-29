//
// DifferentiableTableViewUpdater.swift
// UniversalListController
//

import DifferenceKit
import Foundation
import UIKit

class DifferentiableTableViewUpdater<CellContext, VS: ViewSource>: ReusableViewListUpdater
    where
    VS.View: UITableView,
    CellContext: CellSource,
    CellContext: Differentiable,
    CellContext.Cell: UITableViewCell {

    private let dataSource: TableViewDataSource<Void, CellContext, VS>

    private let viewSource: VS

    private lazy var tableView: VS.View = {
        let tableView = viewSource.view
        tableView.dataSource = dataSource
        tableView.reloadData()
        return tableView
    }()

    init(viewProvider: VS, dataSource: TableViewDataSource<Void, CellContext, VS>) {
        self.dataSource = dataSource
        viewSource = viewProvider
    }

    func update(with data: ListData<Void, CellContext>) {
        guard viewSource.isViewLoaded else {
            return
        }

        let source = dataSource.data.getAsDifferentiableArray()
        let target = data.getAsDifferentiableArray()
        let changeSet = StagedChangeset(source: source, target: target)
        tableView.reload(using: changeSet, with: .fade) { data in
            let sections = data.map { SectionData(cells: $0.elements.map { CellData(context: $0) }) }
            dataSource.data = ListData(sections: sections)
        }
    }

}
