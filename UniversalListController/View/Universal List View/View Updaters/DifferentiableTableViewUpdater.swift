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

    /// Postponed data
    private var postponedData: ListData<DataSource.SectionContext, DataSource.CellContext>?

    /// Updating flag
    private var isUpdating: Bool = false

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
        guard !isUpdating else {
            postponedData = data
            return
        }

        isUpdating = true
        let source = previousData.getAsDifferentiableArray()
        let target = data.getAsDifferentiableArray()
        let changeSet = StagedChangeset(source: source,
                                        target: target)
        previousData = data
        CATransaction.begin()
        CATransaction.setCompletionBlock { [weak self] in
            guard let self = self else {
                return
            }
            if let postponedData = self.postponedData {
                DispatchQueue.main.async {
                    self.isUpdating = false
                    self.postponedData = nil
                    self.update(with: postponedData)
                }
            } else {
                self.isUpdating = false
            }
        }
        tableView.reload(using: changeSet, with: .fade) { [weak self] data in
            let changedData = ListData(
                sections: data.map {
                    SectionData(
                        cells: $0.elements.map { CellData(context: $0)
                    })
                })
            self?.holder?.data = changedData
        }
        CATransaction.commit()
    }

}
