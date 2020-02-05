//
// TableViewDataSource.swift
// UniversalListController
//

import Foundation
import ReusableView
import UIKit
import UniversalList

public final class TableViewDataSourceController<SectionContext, CellContext, ListHolder: ViewHolder>: NSObject, UniversalListDataSourceController, UITableViewDataSource
    where
    ListHolder.View: UITableView,
    CellContext: CellAdapter,
    CellContext.Cell: UITableViewCell {

    public typealias View = ListHolder.View

    public var data: ListData<SectionContext, CellContext> = ListData(sections: [])

    private let holder: ListHolder
    private let cellDequeuer: TableReusableCellDequeuer<ListHolder>

    public init(holder: ListHolder) {
        self.holder = holder
        cellDequeuer = TableReusableCellDequeuer(holder: holder)

        super.init()
    }

    public func numberOfSections(in tableView: UITableView) -> Int {
        guard holder.isViewLoaded else {
            return 0
        }
        return data.sections.count
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard holder.isViewLoaded else {
            return 0
        }
        return data.sections[section].cells.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellData = data.sections[indexPath.section].cells[indexPath.item]
        let cell = cellData.context.getView(with: DequeuingFactory(using: cellDequeuer, with: indexPath))
        return cell
    }

}
