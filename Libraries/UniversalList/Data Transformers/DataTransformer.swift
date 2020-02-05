//
// DataTransformer.swift
// UniversalListController
//

import Foundation

public protocol DataTransformer {

    associatedtype Source

    associatedtype Target

    func transform(_ data: Source) -> Target

}
