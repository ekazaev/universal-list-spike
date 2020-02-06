//
// DirectDataTransformer.swift
// UniversalListController
//

import Foundation
import ReusableView
import UIKit
import UniversalList

public struct ConfigurableDataTransformer<Data, Cell: ConfigurableReusableView>: DataTransformer
    where
    Data: Collection,
    Data.Element: Collection,
    Data.Element.Element == Cell.Data {

    public typealias SectionContext = Void

    public typealias CellContext = ConfigurableCellAdapter<Cell>

    public init() {}

    public func transform(_ data: Data) -> ListData<SectionContext, CellContext> {
        let listData = ListData(sections: data.map {
            return SectionData(items: $0.map { ConfigurableCellAdapter<Cell>(with: $0) })
        })
        return listData
    }

}
