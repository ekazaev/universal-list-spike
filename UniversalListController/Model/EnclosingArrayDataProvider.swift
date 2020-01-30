//
// EnclosingArrayTransformer.swift
// UniversalListController
//

import Foundation

struct EnclosingArrayDataProvider<DP: DataProvider>: DataProvider {

    private let dataProvider: DP

    init(for dataProvider: DP) {
        self.dataProvider = dataProvider
    }

    func getData() -> [DP.Data] {
        return [dataProvider.getData()]
    }

}
