//
// AnyCollectionCellSource.swift
// UniversalListController
//

import Foundation
import UIKit

struct AnyCollectionCellAdapter: CellAdapter {

    private let box: AnyCellAdapterBox

    init<CS: CellAdapter>(with cellSource: CS) where CS.Cell: UICollectionViewCell {
        box = CellAdapterBox(with: cellSource)
    }

    func getView(with factory: ReusableViewFactory) -> UICollectionViewCell {
        return box.build(with: factory)
    }

}

private protocol AnyCellAdapterBox {

    func build(with factory: ReusableViewFactory) -> UICollectionViewCell

}

private final class CellAdapterBox<CS: CellAdapter>: AnyCellAdapterBox where CS.Cell: UICollectionViewCell {

    private var cellSource: CS

    init(with cellSource: CS) {
        self.cellSource = cellSource
    }

    func build(with factory: ReusableViewFactory) -> UICollectionViewCell {
        return cellSource.getView(with: factory)
    }

}
