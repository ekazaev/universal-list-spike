//
// CityDataProvider.swift
// UniversalListController
//

import Foundation

protocol DataProvider {

    associatedtype Data

    associatedtype Request

    func getData(with request: Request, completion: @escaping (Result<Data, Error>) -> Void)

}

final class CityDataProvider: DataProvider {

    private var requestingQuery: String?

    func getData(with query: String, completion: @escaping (Result<[City], Error>) -> Void) {
        delay {
            guard self.requestingQuery == nil || self.requestingQuery != query else {
                return
            }
            defer {
                self.requestingQuery = nil
            }
            self.requestingQuery = query
            let cities = CityDataMock.cities
            guard !query.isEmpty else {
                return completion(.success(cities))
            }
            let filteredCities = cities.filter { $0.city.contains(query) || $0.description.contains(query) }
            completion(.success(filteredCities))
        }
    }

    private func delay(completion: @escaping () -> Void) {
        let mainQueue = DispatchQueue.main
        let deadline = DispatchTime.now() + .seconds(Int.random(in: 0...2))
        mainQueue.asyncAfter(deadline: deadline) { completion() }
    }

}
