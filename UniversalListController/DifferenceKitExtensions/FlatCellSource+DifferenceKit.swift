//
// FlatCellSource+DifferenceKit.swift
// UniversalListController
//

import DifferenceKit
import Foundation
import UIKit

extension FlatCellSource: Differentiable where Cell.Data: Differentiable {

    var differenceIdentifier: Cell.Data.DifferenceIdentifier {
        return data.differenceIdentifier
    }

    func isContentEqual(to source: FlatCellSource<Cell>) -> Bool {
        return data.isContentEqual(to: source.data)
    }

}
