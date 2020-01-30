//
// DifferentiableTableViewUpdater.swift
// UniversalListController
//

import DifferenceKit
import Foundation
import UIKit

final class DifferentiableTableViewUpdater<CellContext, Source: ViewSource>: ReusableViewListUpdater
    where
    Source.View: UITableView,
    CellContext: CellSource,
    CellContext: Differentiable,
    CellContext.Cell: UITableViewCell {

    private let dataSource: TableViewDataSource<Void, CellContext, Source>

    private let viewSource: Source

    private lazy var tableView: Source.View = {
        let tableView = viewSource.view
        tableView.dataSource = dataSource
        tableView.reloadData()
        return tableView
    }()

    init(viewProvider: Source, dataSource: TableViewDataSource<Void, CellContext, Source>) {
        self.dataSource = dataSource
        viewSource = viewProvider
    }

    func update(with data: ListData<Void, CellContext>) {
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
