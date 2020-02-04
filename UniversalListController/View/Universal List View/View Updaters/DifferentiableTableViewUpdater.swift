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

    /// Data to compare with
    private var previousData = ListData<DataSource.SectionContext, DataSource.CellContext>(sections: [])

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
        guard holder != nil else {
            previousData = data
            return
        }
        guard viewSource.isViewLoaded else {
            previousData = data
            holder?.data = data
            return
        }

        let source = previousData.getAsDifferentiableArray()
        let target = data.getAsDifferentiableArray()
        let changeSet = StagedChangeset(source: source,
            target: target)
        previousData = data
        tableView.reload(using: changeSet, with: .fade) { [weak self] data in
            let changedData = ListData(
                sections: data.map {
                    SectionData(
                        cells: $0.elements.map { CellData(context: $0)
                        })
                })
            self?.holder?.data = changedData
        }
    }

}
