//
// ListData.swift
// UniversalListController
//

import Foundation

public struct ListData<SectionContext, CellContext>: CustomStringConvertible {

    public var sections: [SectionData<SectionContext, CellContext>]

    public init(sections: [SectionData<SectionContext, CellContext>]) {
        self.sections = sections
    }

    public var description: String {
        return "ListData\n" + sections.map { "    \($0.context)\n        \($0.cells.count)" }.joined(separator: "\n")
    }

}

// Not finished
public extension ListData {

    subscript(section: Int, item: Int) -> CellContext {
        get {
            guard section < sections.count else {
                fatalError()
            }
            let sectionData = sections[section]
            guard item < sectionData.cells.count else {
                fatalError()
            }
            return sectionData.cells[item].context
        }
        set {
            guard section < sections.count else {
                return
            }
            var sectionData = sections[section]
            guard item < sectionData.cells.count else {
                return
            }
            var cells = sectionData.cells
            cells.remove(at: item)
            cells.insert(CellData(context: newValue), at: item)
            sectionData.cells = cells
        }
    }

}
