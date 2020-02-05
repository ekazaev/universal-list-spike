//
// AnyCollectionCellAdapter.swift
// UniversalListController
//

import Foundation
import UIKit

public struct AnyCollectionCellAdapter: CellAdapter {

    private let box: AnyCellAdapterBox

    public init<CA: CellAdapter>(with cellAdapter: CA) where CA.Cell: UICollectionViewCell {
        box = CellAdapterBox(with: cellAdapter)
    }

    public func getView(with factory: ReusableViewFactory) -> UICollectionViewCell {
        return box.build(with: factory)
    }

}

private protocol AnyCellAdapterBox {

    func build(with factory: ReusableViewFactory) -> UICollectionViewCell

}

private final class CellAdapterBox<CA: CellAdapter>: AnyCellAdapterBox where CA.Cell: UICollectionViewCell {

    private var cellAdapter: CA

    init(with cellAdapter: CA) {
        self.cellAdapter = cellAdapter
    }

    func build(with factory: ReusableViewFactory) -> UICollectionViewCell {
        return cellAdapter.getView(with: factory)
    }

}
