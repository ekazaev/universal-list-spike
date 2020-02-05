//
// CellData.swift
// UniversalListController
//

import Foundation

public struct CellData<Context> {

    public var context: Context

    public init(context: Context) {
        self.context = context
    }

}
