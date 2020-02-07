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

public extension ListData {

    subscript(sectionIndex: Int) -> SectionData<SectionContext, CellContext>? {
        get {
            guard sectionIndex < sections.count else {
                return nil
            }
            return sections[sectionIndex]
        }
        set {
            guard sectionIndex < sections.count else {
                return
            }
            guard let sectionData = newValue else {
                assertionFailure("Attempt to set an empty value instead of \(String(describing: SectionData<SectionContext, CellContext>.self))")
                return
            }
            sections.remove(at: sectionIndex)
            sections.insert(sectionData, at: sectionIndex)
        }
    }

    subscript(itemsAt sectionIndex: Int) -> [CellContext]? {
        get {
            return self[sectionIndex]?.items
        }
        set {
            guard let items = newValue else {
                assertionFailure("Attempt to set an empty value instead of \(String(describing: [CellContext].self))")
                return
            }
            guard sectionIndex < sections.count else {
                return
            }
            self[sectionIndex]?.items = items
        }
    }

    subscript(section sectionIndex: Int, item itemIndex: Int) -> CellContext? {
        get {
            guard sectionIndex < sections.count else {
                return nil
            }
            let sectionData = sections[sectionIndex]
            guard itemIndex < sectionData.items.count else {
                return nil
            }
            return sectionData.items[itemIndex]
        }
        set {
            guard sectionIndex < sections.count else {
                return
            }
            var sectionData = sections[sectionIndex]
            guard itemIndex < sectionData.items.count else {
                return
            }
            sectionData.items.remove(at: itemIndex)
            guard let cellContext = newValue else {
                assertionFailure("Attempt to set an empty value instead of \(String(describing: CellContext.self))")
                return
            }
            sectionData.items.insert(cellContext, at: itemIndex)
        }
    }

    subscript(indexPath: IndexPath) -> CellContext? {
        get {
            return self[section: indexPath.section, item: indexPath.item]
        }
        set {
            self[section: indexPath.section, item: indexPath.item] = newValue
        }
    }

}
