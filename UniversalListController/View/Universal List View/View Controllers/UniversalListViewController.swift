//
// UniversalListViewController.swift
// UniversalListController
//

import Foundation
import UIKit

final class UniversalListViewController<Factory: ViewFactory, DataSource: ReusableViewListDataSource>: UIViewController
    where
    Factory.View == DataSource.View {

    weak var delegate: UniversalListViewControllerDelegate?

    private let factory: Factory
    private let eventHandler: Any
    private let dataSource: DataSource

    @available(*, unavailable, message: "Use programmatic init instead")
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(factory: Factory, eventHandler: Any, dataSource: DataSource) {
        self.eventHandler = eventHandler
        self.dataSource = dataSource
        self.factory = factory
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        delegate?.listViewInstantiated()
    }

}

private extension UniversalListViewController {

    private func setupView() {
        let listView = factory.build()
        listView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(listView)
        listView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        listView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        listView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        listView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }

}
