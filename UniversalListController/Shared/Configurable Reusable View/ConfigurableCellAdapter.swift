//
// ConfigurableCellAdapter.swift
// UniversalListController
//

import Foundation
import ReusableView
import UIKit

struct ConfigurableCellAdapter<Cell: ConfigurableReusableView>: CellAdapter {

    let data: Cell.Data

    public init(with data: Cell.Data) {
        self.data = data
    }

    func getView(with factory: ReusableViewFactory) -> Cell {
        let cell: Cell = factory.build()
        cell.setup(with: data)
        return cell
    }

}
