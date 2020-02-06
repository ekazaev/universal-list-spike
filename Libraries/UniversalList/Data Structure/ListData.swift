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
        return "ListData\n" + sections.map { "    \($0.section)\n        \($0.items.count)" }.joined(separator: "\n")
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
            guard item < sectionData.items.count else {
                fatalError()
            }
            return sectionData.items[item]
        }
        set {
            guard section < sections.count else {
                return
            }
            var sectionData = sections[section]
            guard item < sectionData.items.count else {
                return
            }
            var cells = sectionData.items
            cells.remove(at: item)
            cells.insert(newValue, at: item)
            sectionData.items = cells
        }
    }

}
