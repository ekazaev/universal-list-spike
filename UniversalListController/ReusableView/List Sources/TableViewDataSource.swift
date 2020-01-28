//
// TableViewDataSource.swift
// UniversalListController
//

import Foundation
import UIKit

class TableViewDataSource<SectionContext, CellContext>: NSObject, UITableViewDataSource
    where
    CellContext: CellSource,
    CellContext.Cell: UITableViewCell {

    var data: ListData<SectionContext, CellContext> = ListData(sections: [])

    private let tableView: UITableView
    private let cellDequeuer: TableReusableCellDequeuer

    init<VP: ListViewProvider>(viewProvider: VP) where VP.ListView == UITableView {
        tableView = viewProvider.listView
        cellDequeuer = TableReusableCellDequeuer(tableView: tableView)

        super.init()

        tableView.dataSource = self
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return data.sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.sections[section].cells.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellBuilder = data.sections[indexPath.section].cells[indexPath.item]
        let cell = cellBuilder.context.getView(with: DequeuerBuilder(using: cellDequeuer, with: indexPath))
        return cell
    }

}
