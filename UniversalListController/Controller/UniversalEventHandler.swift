//
// FlatEventHandler.swift
// UniversalListController
//

import Foundation
import UIKit

class UniversalEventHandler<ViewUpdater: ReusableViewListUpdater, DP: DataProvider, Cell: InjectableReusableView>
    where
    ViewUpdater.SectionContext == Void,
    ViewUpdater.CellContext == FlatCellSource<Cell>,
    DP.Data == Cell.Data {

    private var viewUpdater: ViewUpdater

    private var dataProvider: DP

    private var timer: Timer!

    init(viewUpdater: ViewUpdater, dataProvider: DP) {
        self.viewUpdater = viewUpdater
        self.dataProvider = dataProvider
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            let entities = dataProvider.getData()
            let converter = FlatDataConverter<[[DP.Data]], Cell>()
            let data = converter.transform(data: [entities])
            self?.viewUpdater.update(with: data)
        }
    }
}
