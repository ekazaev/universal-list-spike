//
// DifferentiableTableViewUpdater.swift
// UniversalListController
//

import DifferenceKit
import Foundation
import ReusableView
import UIKit
import UniversalList
import UniversalListViewController

public final class DifferentiableTableViewUpdater<DataSource: UniversalListDataSourceController & UITableViewDataSource, Proxy: ViewAccessProxy>: UniversalListUpdater
    where
    Proxy.View: UITableView,
    DataSource.View: UITableView,
    DataSource.SectionContext == Void,
    DataSource.CellContext: CellAdapter,
    DataSource.CellContext: Differentiable,
    DataSource.CellContext.Cell: UITableViewCell {

    private weak var dataSource: DataSource?

    private let viewProxy: Proxy

    private lazy var tableView: Proxy.View = {
        let tableView = viewProxy.view
        tableView.dataSource = dataSource
        tableView.reloadData()
        return tableView
    }()

    public init(viewProxy: Proxy, dataSource: DataSource) {
        self.dataSource = dataSource
        self.viewProxy = viewProxy
    }

    public func update(with data: ListData<DataSource.SectionContext, DataSource.CellContext>) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }
            guard let viewProxy = self.dataSource else {
                return
            }
            guard self.viewProxy.isViewLoaded else {
                self.dataSource?.data = data
                return
            }
            let source = viewProxy.data.getAsDifferentiableArray()
            let target = data.getAsDifferentiableArray()
            let changeSet = StagedChangeset(source: source, target: target)
            self.tableView.reload(using: changeSet, with: .fade) { data in
                let changedData = ListData(
                    sections: data.map {
                        SectionData(
                            items: $0.elements)
                        })
                viewProxy.data = changedData
            }
        }
    }
}
