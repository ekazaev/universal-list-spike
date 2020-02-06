//
//  Person+DifferenceKit.swift
//  UniversalListController
//
//  Created by Eugene Kazaev on 06/02/2020.
//  Copyright © 2020 Eugene Kazaev. All rights reserved.
//

import DifferenceKit
import Foundation

extension Person: Differentiable {

    public var differenceIdentifier: Int { return id }

    public func isContentEqual(to source: Person) -> Bool {
        return id == source.id
    }

}
