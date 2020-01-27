//
// CitiesViewController.swift
// UniversalListController
//

import Foundation
import UIKit

// class FlatListViewController<SectionContext, CellContext>: UIViewController {
//
//    private let dataSource: UITableViewDataSource
//    private let eventHandler: Any
//    private let tableView = UITableView()
//
//    @available(*, unavailable, message: "Use programmatic init instead")
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    init(dataSourceType: TableViewDataSource<SectionContext, CellContext>, eventHandler: Any) {
//        self.dataSource = TableViewDataSource<SectionContext, CellContext>(tableView: tableView)
//        self.eventHandler = eventHandler
//        super.init(nibName: nil, bundle: nil)
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupView()
//    }
//
// }
//
// extension FlatListViewController: UITableViewDelegate {}
//
// private extension FlatListViewController {
//
//    private func setupView() {
//        let tableView = UITableView(frame: view.bounds)
//        view.addSubview(tableView)
//        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
//        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
//        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
//        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
//    }
//
// }
