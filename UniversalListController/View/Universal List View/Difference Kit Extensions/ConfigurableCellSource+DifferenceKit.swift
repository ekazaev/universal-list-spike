//
// ConfigurableCellSource+DifferenceKit.swift
// UniversalListController
//

import DifferenceKit
import Foundation
import UIKit

extension ConfigurableCellSource: Differentiable where Cell.Data: Differentiable {

    var differenceIdentifier: Cell.Data.DifferenceIdentifier {
        return data.differenceIdentifier
    }

    func isContentEqual(to source: ConfigurableCellSource<Cell>) -> Bool {
        return data.isContentEqual(to: source.data)
    }

}
