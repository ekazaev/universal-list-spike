//
// ShufflingDataProvider.swift
// UniversalListController
//

import Foundation

class ShufflingDataProvider<DP: DataProvider>: DataProvider where DP.Data: Collection {

    private let dataProvider: DP

    init(for dataProvider: DP) {
        self.dataProvider = dataProvider
    }

    func getData() -> [DP.Data.Element] {
        return dataProvider.getData().shuffled()
    }

}
