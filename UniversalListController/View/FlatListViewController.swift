//
// CitiesViewController.swift
// UniversalListController
//

import Foundation
import UIKit

protocol ReloadableViewController: UIViewController {

    func reloadData()

}

class FlatListViewController: UIViewController {

    private let dataSource: UITableViewDataSource & TableViewConfigurable
    private let eventHandler: Any
    private var tableView: UITableView!

    @available(*, unavailable, message: "Use programmatic init instead")
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(dataSourceType: UITableViewDataSource & TableViewConfigurable, eventHandler: Any) {
        dataSource = dataSourceType
        self.eventHandler = eventHandler
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

}

extension FlatListViewController: UITableViewDelegate {}

extension FlatListViewController: ReloadableViewController {
    func reloadData() {}
}

private extension FlatListViewController {

    private func setupView() {
        tableView = UITableView(frame: view.bounds)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true

        dataSource.setup(for: tableView)
    }

}
