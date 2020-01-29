//
// SectionData.swift
// UniversalListController
//

import Foundation

struct SectionData<SectionContext, CellContext> {

    let context: SectionContext

    let cells: [CellData<CellContext>]

    init(context: SectionContext, cells: [CellData<CellContext>]) {
        self.context = context
        self.cells = cells
    }

}

extension SectionData where SectionContext == Void {

    init(cells: [CellData<CellContext>]) {
        context = ()
        self.cells = cells
    }

}