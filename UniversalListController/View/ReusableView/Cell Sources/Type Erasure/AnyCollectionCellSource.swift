//
// AnyCollectionCellSource.swift
// UniversalListController
//

import Foundation
import UIKit

struct AnyCollectionCellSource: CellSource {

    private let box: AnyCellSourceBox

    init<CS: CellSource>(with cellSource: CS) where CS.Cell: UICollectionViewCell {
        box = CellSourceBox(with: cellSource)
    }

    func getView(with factory: ReusableViewFactory) -> UICollectionViewCell {
        return box.build(with: factory)
    }

}

private protocol AnyCellSourceBox {

    func build(with factory: ReusableViewFactory) -> UICollectionViewCell

}

private final class CellSourceBox<CS: CellSource>: AnyCellSourceBox where CS.Cell: UICollectionViewCell {

    private var cellSource: CS

    init(with cellSource: CS) {
        self.cellSource = cellSource
    }

    func build(with factory: ReusableViewFactory) -> UICollectionViewCell {
        return cellSource.getView(with: factory)
    }

}
