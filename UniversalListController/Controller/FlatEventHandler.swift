//
// FlatEventHandler.swift
// UniversalListController
//

import Foundation
import UIKit

class FlatEventHandler<ViewUpdater: ReusableViewListUpdater>
    where
    ViewUpdater.SectionContext == Void,
    ViewUpdater.CellContext: CellSource,
    ViewUpdater.CellContext.Cell: UITableViewCell {

    private var viewUpdater: ViewUpdater

    private var timer: Timer!

    init(viewUpdater: ViewUpdater) {
        self.viewUpdater = viewUpdater
//        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
//            let cities = CityDataMock.cities.shuffled()
//            let data = ListData(sections: [SectionData(cells: cities.map { CellData(context: SimpleCellSource<CityTableCell>(with: $0)) })])
//            self?.viewUpdater.update(with: data)
//        }
    }
}
