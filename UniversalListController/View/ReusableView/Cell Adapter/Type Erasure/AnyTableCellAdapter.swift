//
// AnyTableCellSource.swift
// UniversalListController
//

import Foundation
import UIKit

struct AnyTableCellAdapter: CellAdapter {

    private let box: AnyCellAdapterBox

    init<CS: CellAdapter>(with cellSource: CS) where CS.Cell: UITableViewCell {
        box = CellAdapterBox(with: cellSource)
    }

    func getView(with factory: ReusableViewFactory) -> UITableViewCell {
        return box.build(with: factory)
    }

}

private protocol AnyCellAdapterBox {

    func build(with factory: ReusableViewFactory) -> UITableViewCell

}

private final class CellAdapterBox<CS: CellAdapter>: AnyCellAdapterBox where CS.Cell: UITableViewCell {

    private var cellSource: CS

    init(with cellSource: CS) {
        self.cellSource = cellSource
    }

    func build(with factory: ReusableViewFactory) -> UITableViewCell {
        return cellSource.getView(with: factory)
    }

}
