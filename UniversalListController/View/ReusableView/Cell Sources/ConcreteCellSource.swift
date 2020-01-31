//
// ConcreteCellSource.swift
// UniversalListController
//

import Foundation
import UIKit

struct ConcreteCellSource<Cell: ReusableView>: CellSource {

    func getView(with factory: ReusableViewFactory) -> Cell {
        return factory.build()
    }

}
