//
// Created by Eugene Kazaev on 09/02/2020.
// Copyright (c) 2020 Eugene Kazaev. All rights reserved.
//

import Foundation
import UIKit
import UniversalList

public struct ListStateDataTransformer<MainCellAdapter: DataConfigurableCellAdapter,
                                       AccessoryCellAdapter: DataConfigurableCellAdapter>: DataTransformer
    where
    MainCellAdapter.Cell: UITableViewCell,
    AccessoryCellAdapter.Cell: UITableViewCell {

    public init() {}

    public func transform(_ data: [[ListCellType<MainCellAdapter.Data, AccessoryCellAdapter.Data>]]) -> ListData<Void, ListStateCellAdapter<MainCellAdapter, AccessoryCellAdapter>> {
        return ListData(sections: data.map {
            return SectionData(items: $0.map {
                return ListStateCellAdapter(with: $0)
            })
        })
    }

}
