//
// TableViewDataSource.swift
// UniversalListController
//

import Foundation
import UIKit

class TableViewDataSource<SectionContext, CellContext>: NSObject, TableViewConfigurable, UITableViewDataSource
    where
    CellContext: CellSource,
    CellContext.Cell: UITableViewCell {

    var data: ListData<SectionContext, CellContext> = ListData(sections: [])

    private var cellDequeuer: TableReusableCellDequeuer?

    override init() {
        super.init()
    }

    func setup(for tableView: UITableView) {
        cellDequeuer = TableReusableCellDequeuer(tableView: tableView)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return data.sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.sections[section].cells.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellDequeuer = cellDequeuer else {
            assertionFailure("Data Source was not properly setup for use")
            return UITableViewCell()
        }

        let cellBuilder = data.sections[indexPath.section].cells[indexPath.item]
        let cell = cellBuilder.context.getView(with: DequeuerBuilder(using: cellDequeuer, with: indexPath))
        return cell
    }

}
