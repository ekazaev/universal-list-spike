//
// CitiesViewController.swift
// UniversalListController
//

import Foundation
import UIKit

class FlatListViewController: UIViewController {

    private let eventHandler: Any
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: view.bounds)
        viewUpdater.setup(for: tableView)
        return tableView
    }()

    private let viewUpdater: TableViewConfigurable

    @available(*, unavailable, message: "Use programmatic init instead")
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(viewUpdater: TableViewConfigurable, eventHandler: Any) {
        self.eventHandler = eventHandler
        self.viewUpdater = viewUpdater
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

}

private extension FlatListViewController {

    private func setupView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }

}
