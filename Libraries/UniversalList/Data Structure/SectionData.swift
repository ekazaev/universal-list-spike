//
// SectionData.swift
// UniversalListController
//

import Foundation

public struct SectionData<SectionContext, CellContext> {

    public var section: SectionContext

    public var items: [CellContext]

    init(section: SectionContext, items: [CellContext]) {
        self.section = section
        self.items = items
    }

}

public extension SectionData where SectionContext == Void {

    init(items: [CellContext]) {
        section = ()
        self.items = items
    }

}
