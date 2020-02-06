//
// Created by Eugene Kazaev on 05/02/2020.
// Copyright (c) 2020 Eugene Kazaev. All rights reserved.
//

import DifferenceKit
import Foundation
import UIKit

extension ListCellType: Differentiable where Data: Differentiable, Data.DifferenceIdentifier == Int {

    var differenceIdentifier: Data.DifferenceIdentifier {
        switch self {
        case let .dataCell(data):
            return data.differenceIdentifier
        case .loadingCell:
            return Int.max
        }
    }

    func isContentEqual(to source: ListCellType<Data>) -> Bool {
        switch (self, source) {
        case let (.dataCell(data), .dataCell(sourceData)):
            return data.isContentEqual(to: sourceData)
        case (.loadingCell, .loadingCell):
            return true
        case (.loadingCell, .dataCell(_)):
            return false
        case (.dataCell(_), .loadingCell):
            return false
        }
    }

}
