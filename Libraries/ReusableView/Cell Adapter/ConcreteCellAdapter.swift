//
// ConcreteCellAdapter.swift
// UniversalListController
//

import Foundation
import UIKit

public struct ConcreteCellAdapter<Cell: ReusableView>: CellAdapter {

    public init() {}

    public func getView(with factory: ReusableViewFactory) -> Cell {
        return factory.build()
    }

}
