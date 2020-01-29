//
// DataTransformer.swift
// UniversalListController
//

import Foundation

protocol DataTransformer {

    associatedtype Data

    associatedtype SectionContext

    associatedtype CellContext

    func transform(_ data: Data) -> ListData<SectionContext, CellContext>

}
