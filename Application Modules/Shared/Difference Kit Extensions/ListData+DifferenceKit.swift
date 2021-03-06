//
// ListData+DifferenceKit.swift
// UniversalListController
//

import DifferenceKit
import Foundation
import UniversalList

public extension ListData where SectionContext == Void, CellContext: Differentiable {

    func getAsDifferentiableArray() -> [ArraySection<Int, CellContext>] {
        return sections.enumerated().map {
            ArraySection(model: $0.offset, elements: $0.element.items.map { $0 })
        }
    }

}

extension Int: Differentiable {}

extension String: Differentiable {}
