//
// DifferentiableTableViewUpdater.swift
// UniversalListController
//

import DifferenceKit
import Foundation
import UIKit

final class DifferentiableTableViewUpdater<DataSource: ReusableViewListDataSource & UITableViewDataSource, ViewSource: ListViewSource>: ReusableViewListUpdater
    where
    ViewSource.View: UITableView,
    DataSource.View: UITableView,
    DataSource.SectionContext == Void,
    DataSource.CellContext: CellSource,
    DataSource.CellContext: Differentiable,
    DataSource.CellContext.Cell: UITableViewCell {

    private var dataSource: DataSource

    private let viewSource: ViewSource

    private lazy var tableView: ViewSource.View = {
        let tableView = viewSource.view
        tableView.dataSource = dataSource
        tableView.reloadData()
        return tableView
    }()

    init(viewProvider: ViewSource, dataSource: DataSource) {
        self.dataSource = dataSource
        viewSource = viewProvider
    }

    func update(with data: ListData<DataSource.SectionContext, DataSource.CellContext>) {
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
