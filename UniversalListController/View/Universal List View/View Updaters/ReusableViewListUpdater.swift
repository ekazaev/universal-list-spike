//
// ReusableViewListUpdater.swift
// UniversalListController
//

import Foundation
import UIKit

protocol ReusableViewListUpdater {

    associatedtype SectionContext

    associatedtype CellContext

    func update(with data: ListData<SectionContext, CellContext>)

}
