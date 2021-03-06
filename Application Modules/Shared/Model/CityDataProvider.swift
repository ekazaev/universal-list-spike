//
// CityDataProvider.swift
// UniversalListController
//

import Foundation

public final class CityDataProvider: DataProvider {

    public init() {}

    public func getData(with query: String,
                        completion: @escaping (Result<[City], Error>) -> Void) {
        delay {
            let cities = StaticCityData.cities.sorted(by: { $0.city < $1.city })
            guard !query.isEmpty else {
                return completion(.success(cities))
            }
            let filteredCities = cities.filter {
                $0.city.lowercased().contains(query.lowercased()) || $0.description.lowercased().contains(query.lowercased())
            }
            completion(.success(filteredCities))
        }
    }

    private func delay(completion: @escaping () -> Void) {
        let mainQueue = DispatchQueue.main
        let deadline = DispatchTime.now() + .milliseconds(Int.random(in: 0...500))
        mainQueue.asyncAfter(deadline: deadline) {
            completion()
        }
    }

}
