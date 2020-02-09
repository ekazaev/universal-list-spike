//
// Created by Eugene Kazaev on 09/02/2020.
// Copyright (c) 2020 Eugene Kazaev. All rights reserved.
//

import Foundation
import ReusableView
import UIKit
import UniversalList

public struct ListStateCellAdapter<MainCellAdapter: DataConfigurableCellAdapter,
                                   AccessoryCellAdapter: DataConfigurableCellAdapter>: CellAdapter
    where
    MainCellAdapter.Cell: UITableViewCell,
    AccessoryCellAdapter.Cell: UITableViewCell {

    let listState: ListCellType<MainCellAdapter.Data, AccessoryCellAdapter.Data>

    public init(with data: ListCellType<MainCellAdapter.Data, AccessoryCellAdapter.Data>) {
        listState = data
    }

    public func getView(with factory: ReusableViewFactory) -> UITableViewCell {
        switch listState {
        case let .dataCell(data):
            return MainCellAdapter(with: data).getView(with: factory)
        case let .accessoryCell(accessory):
            return AccessoryCellAdapter(with: accessory).getView(with: factory)
        }
    }

}
