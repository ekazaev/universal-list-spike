//
// SectionData.swift
// UniversalListController
//

import Foundation

/// Data structure that represents section
public struct SectionData<SectionContext, CellContext> {

    /// Section data
    public var section: SectionContext

    /// Array of enclosing cell data
    public var items: [CellContext]

    /// Constructor
    /// - Parameters:
    ///   - section: Section data of `SectionContext` type
    ///   - items: An `Array` of cell data of `CellContext` type
    init(section: SectionContext, items: [CellContext]) {
        self.section = section
        self.items = items
    }

}

public extension SectionData where SectionContext == Void {

    /// Constructor
    /// - Parameters:
    ///   - items: An `Array` of cell data of `CellContext` type
    init(items: [CellContext]) {
        section = ()
        self.items = items
    }

}

public extension SectionData where CellContext == Void {

    /// Constructor
    /// - Parameters:
    ///   - section: Section data of `SectionContext` type
    init(section: SectionContext) {
        self.section = section
        items = []
    }

}
