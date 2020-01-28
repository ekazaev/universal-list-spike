//
// CitiesViewController.swift
// UniversalListController
//

import Foundation
import UIKit

protocol ReloadableViewController: UIViewController {

    func reloadData()

}

class FlatListViewController<ViewUpdater: ReusableViewListUpdater & TableViewConfigurable, Cell: InjectableReusableView>: UIViewController
    where
    ViewUpdater.SectionContext == Void,
    ViewUpdater.CellContext == FlatCellSource<Cell>,
    ViewUpdater.CellContext.Cell == Cell {

    private let eventHandler: Any
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: view.bounds)
        viewUpdater.setup(for: tableView)
        return tableView
    }()

    private let viewUpdater: ViewUpdater

    @available(*, unavailable, message: "Use programmatic init instead")
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(viewUpdater: ViewUpdater, eventHandler: Any) {
        self.eventHandler = eventHandler
        self.viewUpdater = viewUpdater
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

}

extension FlatListViewController: ReloadableViewController {
    func reloadData() {}
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
