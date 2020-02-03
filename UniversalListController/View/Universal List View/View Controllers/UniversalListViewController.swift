//
// UniversalListViewController.swift
// UniversalListController
//

import Foundation
import UIKit

final class UniversalListViewController<Factory: ViewFactory, DataSource: ReusableViewListDataSourceController, Delegate: ReusableViewListDelegateController>: UIViewController
    where
    Factory.View == DataSource.View,
    Factory.View == Delegate.View {

    var eventHandler: UniversalListViewControllerDelegate?

    private let factory: Factory
    private let dataSourceController: DataSource
    private let delegateController: Delegate

    @available(*, unavailable, message: "Use programmatic init instead")
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(factory: Factory, dataSourceController: DataSource, delegateController: Delegate) {
        self.dataSourceController = dataSourceController
        self.delegateController = delegateController
        self.factory = factory
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        eventHandler?.listViewInstantiated()
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
