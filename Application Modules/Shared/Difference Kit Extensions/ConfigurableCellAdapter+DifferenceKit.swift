//
// ConfigurableCellAdapter+DifferenceKit.swift
// UniversalListController
//

import DifferenceKit
import Foundation
import ReusableView
import UIKit

extension ConfigurableCellAdapter: Differentiable where Cell.Data: Differentiable {

    public var differenceIdentifier: Cell.Data.DifferenceIdentifier {
        return data.differenceIdentifier
    }

    public func isContentEqual(to source: ConfigurableCellAdapter<Cell>) -> Bool {
        return data.isContentEqual(to: source.data)
    }

}
