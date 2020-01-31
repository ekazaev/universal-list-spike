//
// CellSource.swift
// UniversalListController
//

import Foundation
import UIKit

protocol CellAdapter {

    associatedtype Cell

    func getView(with factory: ReusableViewFactory) -> Cell

}
