//
// ReusableViewListDataSource.swift
// UniversalListController
//

import Foundation
import UIKit

protocol ReusableViewListDataSource {

    associatedtype View: UIView

    associatedtype SectionContext

    associatedtype CellContext

    var data: ListData<SectionContext, CellContext> { get set }

}
