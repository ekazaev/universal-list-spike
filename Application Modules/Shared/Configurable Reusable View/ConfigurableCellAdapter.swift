//
// ConfigurableCellAdapter.swift
// UniversalListController
//

import Foundation
import ReusableView
import UIKit

public protocol DataConfigurableCellAdapter: CellAdapter {

    associatedtype Data

    init(with data: Data)

}

public struct ConfigurableCellAdapter<ConfigurableCell: ConfigurableReusableView>: DataConfigurableCellAdapter {

    public typealias Data = Cell.Data

    public typealias Cell = ConfigurableCell

    public let data: Cell.Data

    public init(with data: Cell.Data) {
        self.data = data
    }

    public func getView(with factory: ReusableViewFactory) -> ConfigurableCell {
        let cell: ConfigurableCell = factory.build()
        cell.setup(with: data)
        return cell
    }

}
