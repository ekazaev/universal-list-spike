//
// ShufflingDataProvider.swift
// UniversalListController
//

import Foundation

// Gets any data ad shuffles it before returning
public class ShufflingDataProvider<DP: DataProvider>: DataProvider where DP.Data: Collection {

    private let dataProvider: DP

    public init(for dataProvider: DP) {
        self.dataProvider = dataProvider
    }

    public func getData(with request: DP.Request, completion: @escaping (Result<[DP.Data.Element], Error>) -> Void) {
        dataProvider.getData(with: request) { result in
            switch result {
            case let .success(data):
                completion(.success(data.shuffled()))
            case let .failure(error):
                return completion(.failure(error))
            }
        }
    }

}
