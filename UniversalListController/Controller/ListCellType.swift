//
// ListState.swift
// UniversalListController
//

import DifferenceKit
import Foundation
import ReusableView
import UIKit
import UniversalList

enum ListCellType<Data> {

    case dataCell(Data)

    case loading

}

extension ListCellType: Differentiable where Data: Differentiable, Data.DifferenceIdentifier == Int {

    var differenceIdentifier: Data.DifferenceIdentifier {
        switch self {
        case let .dataCell(data):
            return data.differenceIdentifier
        case .loading:
            return Int.max
        }
    }

    func isContentEqual(to source: ListCellType<Data>) -> Bool {
        switch (self, source) {
        case let (.dataCell(data), .dataCell(sourceData)):
            return data.isContentEqual(to: sourceData)
        case (.loading, .loading):
            return true
        case (.loading, .dataCell(_)):
            return false
        case (.dataCell(_), .loading):
            return false
        }
    }

}

// Option one: Translate cells in the adapter
struct ListStateCellAdapter<DataCell: ConfigurableReusableView, LoadingCell: ReusableView>: CellAdapter where DataCell: UITableViewCell, LoadingCell: UITableViewCell {

    private let listState: ListCellType<DataCell.Data>

    init(with data: ListCellType<DataCell.Data>) {
        listState = data
    }

    func getView(with factory: ReusableViewFactory) -> UITableViewCell {
        switch listState {
        case let .dataCell(data):
            return ConfigurableCellAdapter<DataCell>(with: data).getView(with: factory)
        case .loading:
            return ConcreteCellAdapter<LoadingCell>().getView(with: factory)
        }
    }

}

extension ListStateCellAdapter: Differentiable where DataCell.Data: Differentiable, DataCell.Data.DifferenceIdentifier == Int {

    var differenceIdentifier: DataCell.Data.DifferenceIdentifier {
        return listState.differenceIdentifier
    }

    func isContentEqual(to source: ListStateCellAdapter<DataCell, LoadingCell>) -> Bool {
        return listState.isContentEqual(to: source.listState)
    }

}

struct ListStateDataTransformer<DataCell: ConfigurableReusableView, LoadingCell: ReusableView>: DataTransformer where DataCell: UITableViewCell, LoadingCell: UITableViewCell {

    func transform(_ data: [[ListCellType<DataCell.Data>]]) -> ListData<Void, ListStateCellAdapter<DataCell, LoadingCell>> {
        return ListData(sections: data.map {
            return SectionData(cells: $0.map {
                return CellData(context: ListStateCellAdapter(with: $0))
            })
        })
    }

}

// Option 2: Translate in the transformer, No adapter needed but can not be extended as differentiable as
// it is uses the CellAdapter with the erased type
struct ListStateTableDataTransformer<DataCell: UITableViewCell & ConfigurableReusableView,
                                     LoadingCell: UITableViewCell & ReusableView>: DataTransformer {

    func transform(_ data: [[ListCellType<DataCell.Data>]]) -> ListData<Void, AnyTableCellAdapter> {
        let listData = ListData<Void, AnyTableCellAdapter>(sections: data.map {
            return SectionData(cells: $0.map {
                switch $0 {
                case let .dataCell(cellData):
                    return CellData(context: AnyTableCellAdapter(with: ConfigurableCellAdapter<DataCell>(with: cellData)))
                case .loading:
                    return CellData(context: AnyTableCellAdapter(with: ConcreteCellAdapter<LoadingCell>()))
                }
            })
        })
        return listData
    }

}
