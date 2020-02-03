//
// PaginatingDataProvider.swift
// UniversalListController
//

import Foundation

// This object exists only for the demo purposes
final class PaginatingDataProvider<DP: DataProvider, Element>: DataProvider where DP.Data == [Element] {

    let itemsPerPage: Int

    private let provider: DP

    private var data: DP.Data?

    init(for provider: DP, itemsPerPage: Int) {
        self.provider = provider
        self.itemsPerPage = itemsPerPage
    }

    func getData() -> DP.Data {
        if data == nil {
            data = provider.getData()
        }
        guard var data = data else {
            return [Element]()
        }
        let pageData = data.prefix(itemsPerPage)
        if itemsPerPage < data.count {
            data.removeFirst(itemsPerPage)
        } else {
            data = []
        }
        self.data = data
        return Array(pageData)
    }

}
