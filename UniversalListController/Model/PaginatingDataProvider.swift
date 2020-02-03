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

    func getData(with request: DP.Request,
                 completion: @escaping (Result<DP.Data, Error>) -> Void) {
        if data == nil {
            provider.getData(with: request) { [weak self] result in
                guard let self = self, let data = try? result.get() else {
                    return
                }
                `self`.data = data
                let pagedData = self.getPagedData()
                completion(.success(pagedData))
            }
        } else {
            let pagedData = getPagedData()
            completion(.success(pagedData))
        }
    }

    private func getPagedData() -> DP.Data {
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
