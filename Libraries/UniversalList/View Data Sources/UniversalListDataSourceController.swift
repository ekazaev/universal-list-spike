//
// ReusableViewListDataSource.swift
// UniversalListController
//

import Foundation
import ReusableView
import UIKit

public protocol UniversalListDataSourceController: AnyObject {

    associatedtype View: UIView

    associatedtype SectionContext

    associatedtype CellContext

    var data: ListData<SectionContext, CellContext> { get set }

}

public extension UniversalListDataSourceController where CellContext: CellAdapter, CellContext.Cell: UIView {

    func buildCell(for indexPath: IndexPath, using factory: ReusableViewFactory) -> CellContext.Cell {
        guard let adapter = data[indexPath] else {
            assertionFailure("Cell IndexPath does not match current DataSource")
            return CellContext.Cell()
        }
        let cell = adapter.getView(with: factory)
        return cell
    }

}
