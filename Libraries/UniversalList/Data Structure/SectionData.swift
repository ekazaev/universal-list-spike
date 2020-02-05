//
// SectionData.swift
// UniversalListController
//

import Foundation

public struct SectionData<SectionContext, CellContext> {

    public var context: SectionContext

    public var cells: [CellData<CellContext>]

    init(context: SectionContext, cells: [CellData<CellContext>]) {
        self.context = context
        self.cells = cells
    }

}

public extension SectionData where SectionContext == Void {

    init(cells: [CellData<CellContext>]) {
        context = ()
        self.cells = cells
    }

}
