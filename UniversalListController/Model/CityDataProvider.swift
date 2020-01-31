//
// CityDataProvider.swift
// UniversalListController
//

import Foundation

protocol DataProvider {

    associatedtype Data

    func getData() -> Data

}

struct CityDataProvider: DataProvider {

    func getData() -> [City] {
        let cities = CityDataMock.cities
        return cities
    }

}
