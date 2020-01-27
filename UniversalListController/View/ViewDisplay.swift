//
// ViewDisplay.swift
// UniversalListController
//

import DifferenceKit
import Foundation
import UIKit

struct ListData<SectionContext, CellContext> {

    var sections: [SectionData<SectionContext, CellContext>]

}

struct SectionData<SectionContext, CellContext> {

    let context: SectionContext

    let cells: [CellData<CellContext>]

    init(context: SectionContext, cells: [CellData<CellContext>]) {
        self.context = context
        self.cells = cells
    }

}

extension SectionData where SectionContext == Void {

    init(cells: [CellData<CellContext>]) {
        context = ()
        self.cells = cells
    }

}

struct CellData<Context> {

    let context: Context

}

protocol CellSource {

    associatedtype Cell: ReusableView

    func getView(with builder: ReusableViewBuilder) -> Cell

}

protocol SimpleCellSourceCell: UITableViewCell {

    associatedtype Data

    func setup(with data: Data)

}

struct SimpleCellSource<Cell: SimpleCellSourceCell>: CellSource {

    public let data: Cell.Data

    init(with data: Cell.Data) {
        self.data = data
    }

    func getView(with builder: ReusableViewBuilder) -> Cell {
        let cell: Cell = builder.build()
        cell.setup(with: data)
        return cell
    }

}

extension SimpleCellSource: Differentiable where Cell.Data: Differentiable {

    var differenceIdentifier: Cell.Data.DifferenceIdentifier {
        return data.differenceIdentifier
    }

    func isContentEqual(to source: SimpleCellSource<Cell>) -> Bool {
        return data.isContentEqual(to: source.data)
    }

}

class TableViewDataSource<SectionContext, CellContext>: NSObject, UITableViewDataSource
    where
    CellContext: CellSource,
    CellContext.Cell: UITableViewCell {

    var data: ListData<SectionContext, CellContext> = ListData(sections: [])

    private let tableView: UITableView
    private let cellDequeuer: TableReusableCellDequeuer

    init(tableView: UITableView) {
        self.tableView = tableView
        cellDequeuer = TableReusableCellDequeuer(tableView: tableView)
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
