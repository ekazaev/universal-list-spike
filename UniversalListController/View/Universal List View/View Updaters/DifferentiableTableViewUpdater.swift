//
// DifferentiableTableViewUpdater.swift
// UniversalListController
//

import DifferenceKit
import Foundation
import ReusableView
import UIKit

final class DifferentiableTableViewUpdater<DataSource: ReusableViewListDataSourceController & UITableViewDataSource, ListHolder: ViewHolder>: ReusableViewListUpdater
    where
    ListHolder.View: UITableView,
    DataSource.View: UITableView,
    DataSource.SectionContext == Void,
    DataSource.CellContext: CellAdapter,
    DataSource.CellContext: Differentiable,
    DataSource.CellContext.Cell: UITableViewCell {

    private weak var dataSource: DataSource?

    private let holder: ListHolder

    private lazy var tableView: ListHolder.View = {
        let tableView = holder.view
        tableView.dataSource = dataSource
        tableView.reloadData()
        return tableView
    }()

    init(holder: ListHolder, dataSource: DataSource) {
        self.dataSource = dataSource
        self.holder = holder
    }

    func update(with data: ListData<DataSource.SectionContext, DataSource.CellContext>) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }
            guard let holder = self.dataSource else {
                return
            }
            guard self.holder.isViewLoaded else {
                self.dataSource?.data = data
                return
            }
            let source = holder.data.getAsDifferentiableArray() // previousData.getAsDifferentiableArray()
            let target = data.getAsDifferentiableArray()
            let changeSet = StagedChangeset(source: source, target: target)
            self.tableView.reload(using: changeSet, with: .fade) { data in
                let changedData = ListData(
                    sections: data.map {
                        SectionData(
                            cells: $0.elements.map {
                                CellData(context: $0)
                                    })
                        })
                holder.data = changedData
            }
        }
    }
}
