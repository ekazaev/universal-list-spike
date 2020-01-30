//
// TableViewFactory.swift
// UniversalListController
//

import Foundation
import UIKit

final class TableViewFactory: ListViewSource, ViewFactory {

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

    weak var delegate: UITableViewDelegate? {
        didSet {
            guard isViewLoaded else {
                return
            }
            view.delegate = delegate
        }
    }

    weak var dataSource: UITableViewDataSource? {
        didSet {
            guard isViewLoaded else {
                return
            }
            view.dataSource = dataSource
        }
    }

    init(style: UITableView.Style = .plain,
         delegate: UITableViewDelegate? = nil,
         dataSource: UITableViewDataSource? = nil) {
        self.style = style
        self.delegate = delegate
        self.dataSource = dataSource
    }

    func build() -> UITableView {
        if let tableView = tableView {
            assertionFailure("Factory method called more then one time")
            return tableView
        }

        let tableView = UITableView(frame: UIScreen.main.bounds, style: style)
        tableView.delegate = delegate
        tableView.dataSource = dataSource
        self.tableView = tableView
        return tableView
    }

}
