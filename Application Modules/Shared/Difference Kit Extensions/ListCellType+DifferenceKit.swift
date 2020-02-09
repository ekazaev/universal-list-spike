//
// Created by Eugene Kazaev on 09/02/2020.
// Copyright (c) 2020 Eugene Kazaev. All rights reserved.
//

import DifferenceKit
import Foundation

extension ListCellType: Differentiable where Data: Differentiable, Accessory: Differentiable {

    public enum ListStateDifferenceIdentifier<Data: Hashable, Accessory: Hashable>: Hashable {
        case dataId(Data)
        case accessoryId(Accessory)
    }

    public var differenceIdentifier: ListStateDifferenceIdentifier<Data.DifferenceIdentifier, Accessory.DifferenceIdentifier> {
        switch self {
        case let .dataCell(data):
            return ListStateDifferenceIdentifier<Data.DifferenceIdentifier, Accessory.DifferenceIdentifier>.dataId(data.differenceIdentifier)
        case let .accessoryCell(accessory):
            return ListStateDifferenceIdentifier<Data.DifferenceIdentifier, Accessory.DifferenceIdentifier>.accessoryId(accessory.differenceIdentifier)
        }
    }

    public func isContentEqual(to source: ListCellType<Data, Accessory>) -> Bool {
        switch (self, source) {
        case let (.dataCell(data), .dataCell(sourceData)):
            return data.isContentEqual(to: sourceData)
        case let (.accessoryCell(accessory), .accessoryCell(sourceAccessory)):
            return accessory.isContentEqual(to: sourceAccessory)
        case (.accessoryCell, .dataCell(_)):
            return false
        case (.dataCell(_), .accessoryCell):
            return false
        }
    }

}
