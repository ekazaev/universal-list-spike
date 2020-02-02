//
// TableViewDataSource.swift
// UniversalListController
//

import Foundation
import UIKit

final class TableViewDataSourceController<SectionContext, CellContext, ListHolder: ViewHolder>: NSObject, ReusableViewListDataSourceController, UITableViewDataSource
    where
    ListHolder.View: UITableView,
    CellContext: CellAdapter,
    CellContext.Cell: UITableViewCell {

    typealias View = ListHolder.View

    var data: ListData<SectionContext, CellContext> = ListData(sections: [])

    private let holder: ListHolder
    private let cellDequeuer: TableReusableCellDequeuer<ListHolder>

    init(holder: ListHolder) {
        self.holder = holder
        cellDequeuer = TableReusableCellDequeuer(holder: holder)

        super.init()
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        guard holder.isViewLoaded else {
            return 0
        }
        return data.sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard holder.isViewLoaded else {
            return 0
        }
        return data.sections[section].cells.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellData = data.sections[indexPath.section].cells[indexPath.item]
        let cell = cellData.context.getView(with: DequeuingFactory(using: cellDequeuer, with: indexPath))
        return cell
    }

}
