//
// Created by Eugene Kazaev on 09/02/2020.
// Copyright (c) 2020 Eugene Kazaev. All rights reserved.
//

import DifferenceKit
import Foundation

extension ListStateCellAdapter: Differentiable
    where
    MainCellAdapter.Data: Differentiable,
    AccessoryCellAdapter.Data: Differentiable {

    public var differenceIdentifier: ListCellType<MainCellAdapter.Data, AccessoryCellAdapter.Data>.ListStateDifferenceIdentifier<MainCellAdapter.Data.DifferenceIdentifier, AccessoryCellAdapter.Data.DifferenceIdentifier> { // ListStateDifferenceIdentifier<MainCellAdapter.Data.DifferenceIdentifier, AccessoryCellAdapter.Data.DifferenceIdentifier> {
        return listState.differenceIdentifier
    }

    public func isContentEqual(to source: ListStateCellAdapter<MainCellAdapter, AccessoryCellAdapter>) -> Bool {
        return listState.isContentEqual(to: source.listState)
    }
}
