//
// ConcreteCellAdapter.swift
// UniversalListController
//

import Foundation
import UIKit

struct ConcreteCellAdapter<Cell: ReusableView>: CellAdapter {

    func getView(with factory: ReusableViewFactory) -> Cell {
        return factory.build()
    }

}
