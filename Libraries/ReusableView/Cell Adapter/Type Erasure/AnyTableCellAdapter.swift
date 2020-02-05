//
// AnyTableCellAdapter.swift
// UniversalListController
//

import Foundation
import UIKit

public struct AnyTableCellAdapter: CellAdapter {

    private let box: AnyCellAdapterBox

    public init<CA: CellAdapter>(with cellAdapter: CA) where CA.Cell: UITableViewCell {
        box = CellAdapterBox(with: cellAdapter)
    }

    public func getView(with factory: ReusableViewFactory) -> UITableViewCell {
        return box.build(with: factory)
    }

}

private protocol AnyCellAdapterBox {

    func build(with factory: ReusableViewFactory) -> UITableViewCell

}

private final class CellAdapterBox<CA: CellAdapter>: AnyCellAdapterBox where CA.Cell: UITableViewCell {

    private var cellAdapter: CA

    init(with cellAdapter: CA) {
        self.cellAdapter = cellAdapter
    }

    func build(with factory: ReusableViewFactory) -> UITableViewCell {
        return cellAdapter.getView(with: factory)
    }

}
