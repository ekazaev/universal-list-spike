//
// TableViewFactory.swift
// UniversalListController
//

import Foundation
import UIKit

class TableViewFactory: ViewSource, ViewFactory {

    private var tableView: UITableView?

    lazy var view: UITableView = {
        guard let tableView = tableView else {
            assertionFailure("Factory method was not called in a correct order")
            return build()
        }
        return tableView
    }()

    init() {}

    func build() -> UITableView {
        if let tableView = tableView {
            assertionFailure("Factory method called more then one time")
            return tableView
        }

        let tableView = UITableView(frame: UIScreen.main.bounds)
        self.tableView = tableView
        return tableView
    }

}
