//
// DataTransformer.swift
// UniversalListController
//

import Foundation

public protocol DataTransformer {

    associatedtype Input

    associatedtype Output

    func transform(_ data: Input) -> Output

}
