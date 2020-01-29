//
// FlatCellSource.swift
// UniversalListController
//

import Foundation
import UIKit

struct FlatCellSource<Cell: ConfigurableReusableView>: CellSource {

    public let data: Cell.Data

    init(with data: Cell.Data) {
        self.data = data
    }

    func getView(with factory: ReusableViewFactory) -> Cell {
        let cell: Cell = factory.build()
        cell.setup(with: data)
        return cell
    }

}
