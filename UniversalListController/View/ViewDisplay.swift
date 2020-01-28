//
// ViewDisplay.swift
// UniversalListController
//

import DifferenceKit
import Foundation
import UIKit

protocol TableViewConfigurable {

    func setup(for tableView: UITableView)

}

protocol ListDataConverter {

    associatedtype List

    associatedtype SectionContext

    associatedtype CellContext

    func transform(data: List) -> ListData<SectionContext, CellContext>

}

struct FlatDataConverter<List, Cell: InjectableReusableView>: ListDataConverter
    where
    List: Collection,
    List.Element: Collection,
    List.Element.Element == Cell.Data {

    typealias SectionContext = Void

    typealias CellContext = FlatCellSource<Cell>

    func transform(data: List) -> ListData<SectionContext, CellContext> {
        let listData = ListData(sections: data.map {
            return SectionData(cells: $0.map {
                CellData(context: FlatCellSource<Cell>(with: $0))
            })
        })
        return listData
    }

}

extension Int: Differentiable {}
