//
// ReusableViewListUpdater.swift
// UniversalListController
//

import Foundation
import UIKit

public protocol UniversalListUpdater {

    associatedtype SectionContext

    associatedtype CellContext

    func update(with data: ListData<SectionContext, CellContext>)

}
