//
// EnclosingArrayTransformer.swift
// UniversalListController
//

import Foundation

public struct EnclosingArrayDataProvider<DP: DataProvider>: DataProvider {

    private let dataProvider: DP

    public init(for dataProvider: DP) {
        self.dataProvider = dataProvider
    }

    public func getData(with request: DP.Request, completion: @escaping (Result<[DP.Data], Error>) -> Void) {
        dataProvider.getData(with: request) { result in
            switch result {
            case let .success(data):
                completion(.success([data]))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }

}
