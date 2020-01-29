//
// CityCellEventHandler.swift
// UniversalListController
//

import DifferenceKit
import Foundation

class CityCellEventHandler: CityCellEventHandling {

    var title: String {
        return city.city
    }

    var description: String {
        return city.description
    }

    private var city: City

    init(city: City) {
        self.city = city
    }

}

extension CityCellEventHandler: Differentiable {

    public var differenceIdentifier: Int {
        return city.differenceIdentifier
    }

    public func isContentEqual(to source: CityCellEventHandler) -> Bool {
        return city.isContentEqual(to: source.city)
    }

}
