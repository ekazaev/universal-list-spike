//
// DataTransformer.swift
// UniversalListController
//

import Foundation

protocol DataTransformer {

    associatedtype Source

    associatedtype Target

    func transform(_ data: Source) -> Target

}
