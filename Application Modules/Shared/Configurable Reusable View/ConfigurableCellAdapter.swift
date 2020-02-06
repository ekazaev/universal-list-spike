//
// ConfigurableCellAdapter.swift
// UniversalListController
//

import Foundation
import ReusableView
import UIKit

public struct ConfigurableCellAdapter<Cell: ConfigurableReusableView>: CellAdapter {

    public let data: Cell.Data

    public init(with data: Cell.Data) {
        self.data = data
    }

    public func getView(with factory: ReusableViewFactory) -> Cell {
        let cell: Cell = factory.build()
        cell.setup(with: data)
        return cell
    }

}
