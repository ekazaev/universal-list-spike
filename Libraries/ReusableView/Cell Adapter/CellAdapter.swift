//
// CellAdapter.swift
// UniversalListController
//

import Foundation
import UIKit

public protocol CellAdapter {

    associatedtype Cell

    func getView(with factory: ReusableViewFactory) -> Cell

}
