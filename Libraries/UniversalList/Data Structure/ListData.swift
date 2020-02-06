//
// ListData.swift
// UniversalListController
//

import Foundation

/// Data structure to hold structured list representation
public struct ListData<SectionContext, CellContext>: CustomStringConvertible {

    /// An `Array` of section data
    public var sections: [SectionData<SectionContext, CellContext>]

    /// Constructor
    /// - Parameter sections: An `Array` of section data of `SectionData` type
    public init(sections: [SectionData<SectionContext, CellContext>]) {
        self.sections = sections
    }

    public var description: String {
        return "ListData<\(String(describing: SectionContext.self)), \(String(describing: CellContext.self))>\n" +
            sections.map { "  \($0.section): \($0.items.count)\n\($0.items.map { "    " + String(describing: $0) }.joined(separator: "\n"))" }.joined(separator: "\n")
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
