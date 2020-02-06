//
// PaginatingDataProvider.swift
// UniversalListController
//

import Foundation

// This object exists only for the demo purposes showing the possibility of building the chain or responsibilities with data providers
// Like one data provider requests list of people, another adds information if they are favored or not by the user and so on,
// Does not always work correctly as it does not have the racing condition protection.
public final class PaginatingDataProvider<DP: DataProvider, Element>: PageableDataProvider where DP.Data == [Element], DP.Request: Equatable {

    public let itemsPerPage: Int

    private let provider: DP

    private var data: DP.Data?

    private var lastRequest: DP.Request?

    public init(for provider: DP, itemsPerPage: Int) {
        self.provider = provider
        self.itemsPerPage = itemsPerPage
    }

    public func getData(with request: DP.Request,
                        completion: @escaping (Result<DP.Data, Error>) -> Void) {
        self.lastRequest = request
        let lastRequest: DP.Request? = request
        provider.getData(with: request) { [weak self] result in
            guard let self = self,
                lastRequest == nil || lastRequest == self.lastRequest,
                let data = try? result.get() else {
                    return
            }
            self.data = data
            let pagedData = self.getPagedData()
            completion(.success(pagedData))
        }
    }

    public func getNextPage(completion: @escaping (Result<DP.Data, Error>) -> Void) {
        let lastRequest = self.lastRequest
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .milliseconds(Int.random(in: 0...500))) { [weak self] in
            guard let self = self,
                lastRequest == nil || lastRequest == self.lastRequest
                else {
                    return
            }
            let pagedData = self.getPagedData()
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
