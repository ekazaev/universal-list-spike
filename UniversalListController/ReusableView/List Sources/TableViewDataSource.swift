//
// TableViewDataSource.swift
// UniversalListController
//

import Foundation
import UIKit

class TableViewDataSource<SectionContext, CellContext, VS: ViewSource>: NSObject, UITableViewDataSource
    where
    VS.View: UITableView,
    CellContext: CellSource,
    CellContext.Cell: UITableViewCell {

    var data: ListData<SectionContext, CellContext> = ListData(sections: [])

    private let viewSource: VS
    private let cellDequeuer: TableReusableCellDequeuer<VS>

    init(viewSource: VS) {
        self.viewSource = viewSource
        cellDequeuer = TableReusableCellDequeuer(viewSource: viewSource)

        super.init()
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
