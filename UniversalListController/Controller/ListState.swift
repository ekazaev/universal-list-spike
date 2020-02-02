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

// struct SpecificAdapter<Adapter: CellAdapter>: CellAdapter where Adapter.Cell == UITableViewCell {
//
//    private let adapter: Adapter
//
//    init(for adapter: Adapter) {
//        self.adapter = adapter
//    }
//
//    func getView(with factory: ReusableViewFactory) -> UITableViewCell {
//        return adapter.getView(with: factory)
//    }
//
// }
//
// let a = ListStateCellAdapter<CityTableCell, LoadingTableViewCell>(with: ListState.data(City(cityId: 1, city: "", description: "")))
/// /let sa = SpecificAdapter<ListStateCellAdapter<CityTableCell, LoadingTableViewCell>>(for: a)
// let aa = AnyTableCellAdapter(with: a)

// struct ListStateTableViewAdapter<DataCell: ConfigurableReusableView, LoadingCell: ReusableView>: CellAdapter where DataCell: UITableViewCell, LoadingCell: UITableViewCell {
//
//    private let adapter: ListStateCellAdapter<DataCell, LoadingCell>
//
//    init(for adapter: ListStateCellAdapter<DataCell, LoadingCell>) {
//        self.adapter = adapter
//    }
//
//    func getView(with factory: ReusableViewFactory) -> UITableViewCell {
//        guard let cell = adapter.getView(with: factory) as? UITableViewCell else {
//            return UITableViewCell()
//        }
//        return cell
//    }
//
// }

struct ListStateCellAdapter<DataCell: ConfigurableReusableView, LoadingCell: ReusableView>: CellAdapter where DataCell: UITableViewCell, LoadingCell: UITableViewCell {

    private let listState: ListState<DataCell.Data>

    init(with data: ListState<DataCell.Data>) {
        listState = data
    }

    func getView(with factory: ReusableViewFactory) -> UITableViewCell {
        switch listState {
        case let .data(data):
            return ConfigurableCellAdapter<DataCell>(with: data).getView(with: factory)
        case .loading:
            return ConcreteCellAdapter<LoadingCell>().getView(with: factory)
        }
    }

}

struct ListStateDataTransformer<DataCell: ConfigurableReusableView, LoadingCell: ReusableView>: DataTransformer where DataCell: UITableViewCell, LoadingCell: UITableViewCell {

    func transform(_ data: [[ListState<DataCell.Data>]]) -> ListData<Void, ListStateCellAdapter<DataCell, LoadingCell>> {
        return ListData(sections: data.map {
            return SectionData(cells: $0.map {
                return CellData(context: ListStateCellAdapter(with: $0))
            })
        })
    }

}

struct ListStateTableDataTransformer<Data,
                                     DataCell: UITableViewCell & ConfigurableReusableView,
                                     LoadingCell: UITableViewCell & ReusableView>: DataTransformer
    where
    DataCell.Data == Data {

    func transform(_ data: [[ListState<Data>]]) -> ListData<Void, AnyTableCellAdapter> {
        let listData = ListData<Void, AnyTableCellAdapter>(sections: data.map {
            return SectionData(cells: $0.map {
                switch $0 {
                case let .data(cellData):
                    return CellData(context: AnyTableCellAdapter(with: ConfigurableCellAdapter<DataCell>(with: cellData)))
                case .loading:
                    return CellData(context: AnyTableCellAdapter(with: ConcreteCellAdapter<LoadingCell>()))
                }
            })
        })
        return listData
    }

}
