//
// ConfigurableCellAdapter.swift
// UniversalListController
//

import Foundation
import UIKit

struct ConfigurableCellAdapter<Cell: ConfigurableReusableView>: CellAdapter {

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
