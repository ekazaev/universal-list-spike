//
// CellSource.swift
// UniversalListController
//

import Foundation
import UIKit

protocol CellSource {

    associatedtype Cell: ReusableView

    func getView(with builder: ReusableViewBuilder) -> Cell

}
