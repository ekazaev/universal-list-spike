//
// ListData.swift
// UniversalListController
//

import Foundation

struct ListData<SectionContext, CellContext> {

    var sections: [SectionData<SectionContext, CellContext>]

}

extension ListData: CustomStringConvertible {

    public var description: String {
        return "ListData\n" + sections.map { "    \($0.context)\n        \($0.cells.count)" }.joined(separator: "\n")
    }

}

// Not finished
extension ListData {

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
