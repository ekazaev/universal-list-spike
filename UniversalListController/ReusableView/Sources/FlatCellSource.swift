//
// FlatCellSource.swift
// UniversalListController
//

import Foundation
import UIKit

struct FlatCellSource<Cell: InjectableReusableView>: CellSource {

    public let data: Cell.Data

    init(with data: Cell.Data) {
        self.data = data
    }

    func getView(with builder: ReusableViewBuilder) -> Cell {
        let cell: Cell = builder.build()
        cell.setup(with: data)
        return cell
    }

}