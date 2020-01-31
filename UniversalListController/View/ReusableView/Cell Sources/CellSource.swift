//
// CellSource.swift
// UniversalListController
//

import Foundation
import UIKit

protocol CellSource {

    associatedtype Cell

    func getView(with factory: ReusableViewFactory) -> Cell

}
