//
// TableViewFactory.swift
// UniversalListController
//

import Foundation
import UIKit

class TableViewFactory: ViewSource, ViewFactory {

    var isViewLoaded: Bool {
        return tableView != nil
    }

    lazy var view: UITableView = {
        guard let tableView = tableView else {
            assertionFailure(
                """
                Factory method build was not called before. Probably view controller 
                has not integrated the view into the stack. You can face potential
                side effects
                """
            )
            return build()
        }
        return tableView
    }()

    private var tableView: UITableView?
    private let style: UITableView.Style

    init(style: UITableView.Style = .plain) {
        self.style = style
    }

    func build() -> UITableView {
        if let tableView = tableView {
            assertionFailure("Factory method called more then one time")
            return tableView
        }

        let tableView = UITableView(frame: UIScreen.main.bounds, style: style)
        self.tableView = tableView
        return tableView
    }

}
