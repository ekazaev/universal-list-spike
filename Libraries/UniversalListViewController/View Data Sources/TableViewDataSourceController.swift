//
// TableViewDataSource.swift
// UniversalListController
//

import Foundation
import ReusableView
import UIKit
import UniversalList

public final class TableViewDataSourceController<SectionContext, CellContext, Proxy: ViewAccessProxy>: NSObject, UniversalListDataSourceController, UITableViewDataSource
    where
    Proxy.View: UITableView,
    CellContext: CellAdapter,
    CellContext.Cell: UITableViewCell {

    public typealias View = Proxy.View

    public var data: ListData<SectionContext, CellContext> = ListData(sections: [])

    private let viewProxy: Proxy
    private let cellDequeuer: TableReusableCellDequeuer<Proxy>

    public init(viewProxy: Proxy) {
        self.viewProxy = viewProxy
        cellDequeuer = TableReusableCellDequeuer(viewProxy: viewProxy)

        super.init()
    }

    public func numberOfSections(in tableView: UITableView) -> Int {
        guard viewProxy.isViewLoaded else {
            return 0
        }
        return data.sections.count
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard viewProxy.isViewLoaded else {
            return 0
        }
        return data.sections[section].cells.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellData = data.sections[indexPath.section].cells[indexPath.item]
        let cell = cellData.context.getView(with: DequeuingFactory(using: cellDequeuer, with: indexPath))
        return cell
    }

}
