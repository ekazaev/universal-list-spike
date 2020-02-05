//
// DirectDataTransformer.swift
// UniversalListController
//

import Foundation
import ReusableView
import UIKit
import UniversalList

struct ConfigurableDataTransformer<Data, Cell: ConfigurableReusableView>: DataTransformer
    where
    Data: Collection,
    Data.Element: Collection,
    Data.Element.Element == Cell.Data {

    typealias SectionContext = Void

    typealias CellContext = ConfigurableCellAdapter<Cell>

    init() {}

    func transform(_ data: Data) -> ListData<SectionContext, CellContext> {
        let listData = ListData(sections: data.map {
            return SectionData(cells: $0.map {
                CellData(context: ConfigurableCellAdapter<Cell>(with: $0))
            })
        })
        return listData
    }

}
