//
// FlatEventHandler.swift
// UniversalListController
//

import Foundation
import UIKit

class UniversalEventHandler<ViewUpdater: ReusableViewListUpdater, DP: DataProvider, DC: DataConverter>
    where
    DC.SectionContext == ViewUpdater.SectionContext,
    DC.CellContext == ViewUpdater.CellContext,
    DC.Data == DP.Data {

    private var viewUpdater: ViewUpdater

    private var dataProvider: DP

    private var dataConverter: DC

    private var timer: Timer!

    init(viewUpdater: ViewUpdater, dataProvider: DP, dataConverter: DC) {
        self.viewUpdater = viewUpdater
        self.dataProvider = dataProvider
        self.dataConverter = dataConverter
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            let entities = dataProvider.getData()
            let data = dataConverter.transform(data: entities)
            self?.viewUpdater.update(with: data)
        }
    }
}
