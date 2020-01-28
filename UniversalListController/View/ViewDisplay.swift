//
// ViewDisplay.swift
// UniversalListController
//

import DifferenceKit
import Foundation
import UIKit

protocol DataConverter {

    associatedtype Data

    associatedtype SectionContext

    associatedtype CellContext

    func transform(data: Data) -> ListData<SectionContext, CellContext>

}

struct FlatDataConverter<Data, Cell: InjectableReusableView>: DataConverter
    where
    Data: Collection,
    Data.Element: Collection,
    Data.Element.Element == Cell.Data {

    typealias SectionContext = Void

    typealias CellContext = FlatCellSource<Cell>

    func transform(data: Data) -> ListData<SectionContext, CellContext> {
        let listData = ListData(sections: data.map {
            return SectionData(cells: $0.map {
                CellData(context: FlatCellSource<Cell>(with: $0))
            })
        })
        return listData
    }

}

extension Int: Differentiable {}
