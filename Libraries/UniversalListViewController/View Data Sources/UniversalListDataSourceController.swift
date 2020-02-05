//
// ReusableViewListDataSource.swift
// UniversalListController
//

import Foundation
import UIKit
import UniversalList

public protocol UniversalListDataSourceController: AnyObject {

    associatedtype View: UIView

    associatedtype SectionContext

    associatedtype CellContext

    var data: ListData<SectionContext, CellContext> { get set }

}
