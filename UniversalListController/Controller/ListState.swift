//
// ListState.swift
// UniversalListController
//

import DifferenceKit
import Foundation
import UIKit

enum ListState<Data> {

    case loading

    case data(Data)

}

struct ListStateTableDataTransformer<Data,
                                     DataCell: UITableViewCell & ConfigurableReusableView,
                                     LoadingCell: UITableViewCell & ReusableView>: DataTransformer
    where
    DataCell.Data == Data {

    func transform(_ data: [[ListState<Data>]]) -> ListData<Void, AnyTableCellSource> {
        let listData = ListData<Void, AnyTableCellSource>(sections: data.map {
            return SectionData(cells: $0.map {
                switch $0 {
                case let .data(cellData):
                    return CellData(context: AnyTableCellSource(with: ConfigurableCellSource<DataCell>(with: cellData)))
                case .loading:
                    return CellData(context: AnyTableCellSource(with: ConcreteCellSource<LoadingCell>()))
                }
            })
        })
        return listData
    }

}
