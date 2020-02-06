//
//  City+DifferenceKit.swift
//  UniversalListController
//
//  Created by Eugene Kazaev on 06/02/2020.
//  Copyright © 2020 Eugene Kazaev. All rights reserved.
//

import DifferenceKit
import Foundation

extension City: Differentiable {

    public var differenceIdentifier: Int { return id }

    public func isContentEqual(to source: City) -> Bool {
        return id == source.id
    }

}
