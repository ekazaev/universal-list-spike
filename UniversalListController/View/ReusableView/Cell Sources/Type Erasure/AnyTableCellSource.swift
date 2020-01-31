//
// AnyTableCellSource.swift
// UniversalListController
//

import Foundation
import UIKit

struct AnyTableCellSource: CellSource {

    private let box: AnyCellSourceBox

    init<CS: CellSource>(with cellSource: CS) where CS.Cell: UITableViewCell {
        box = CellSourceBox(with: cellSource)
    }

    func getView(with factory: ReusableViewFactory) -> UITableViewCell {
        return box.build(with: factory)
    }

}

private protocol AnyCellSourceBox {

    func build(with factory: ReusableViewFactory) -> UITableViewCell

}

private final class CellSourceBox<CS: CellSource>: AnyCellSourceBox where CS.Cell: UITableViewCell {

    private var cellSource: CS

    init(with cellSource: CS) {
        self.cellSource = cellSource
    }

    func build(with factory: ReusableViewFactory) -> UITableViewCell {
        return cellSource.getView(with: factory)
    }

}
