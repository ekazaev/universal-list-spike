//
// DifferentiableTableViewUpdater.swift
// UniversalListController
//

import DifferenceKit
import Foundation
import UIKit

final class DifferentiableTableViewUpdater<DataSource: ReusableViewListDataSourceController & UITableViewDataSource, ListHolder: ViewHolder>: ReusableViewListUpdater
    where
    ListHolder.View: UITableView,
    DataSource.View: UITableView,
    DataSource.SectionContext == Void,
    DataSource.CellContext: CellAdapter,
    DataSource.CellContext: Differentiable,
    DataSource.CellContext.Cell: UITableViewCell {

    private weak var holder: DataSource?

    private let viewSource: ListHolder

    private lazy var tableView: ListHolder.View = {
        let tableView = viewSource.view
        tableView.dataSource = holder
        tableView.reloadData()
        return tableView
    }()

    init(holder: ListHolder, dataSource: DataSource) {
        self.holder = dataSource
        viewSource = holder
    }

    func update(with data: ListData<DataSource.SectionContext, DataSource.CellContext>) {
        guard let dataSource = holder else {
            return
        }
        guard viewSource.isViewLoaded else {
            dataSource.data = data
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
