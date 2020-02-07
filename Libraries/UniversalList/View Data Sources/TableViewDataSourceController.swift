//
// TableViewDataSource.swift
// UniversalListController
//

import Foundation
import ReusableView
import UIKit

public final class TableViewDataSourceController<ViewProxy: ViewAccessProxy, SectionContext, CellContext>: NSObject, UniversalListDataSourceController, UITableViewDataSource
    where
    ViewProxy.View: UITableView,
    CellContext: CellAdapter,
    CellContext.Cell: UITableViewCell {

    public typealias View = ViewProxy.View

    public var data: ListData<SectionContext, CellContext> = ListData(sections: [])

    private let viewProxy: ViewProxy
    private let cellDequeuer: TableReusableCellDequeuer<ViewProxy>

    public init(viewProxy: ViewProxy) {
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
        return data.sections[section].items.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return buildCell(for: indexPath, using: DequeuingFactory(using: cellDequeuer, with: indexPath))
    }

}
