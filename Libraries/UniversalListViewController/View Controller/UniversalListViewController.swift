//
// UniversalListViewController.swift
// UniversalListController
//

import Foundation
import UIKit

public final class UniversalListViewController<View, DataSource: UniversalListDataSourceController, Delegate: UniversalListDelegateController>: UIViewController
    where
    View == DataSource.View,
    View == Delegate.View {

    public var eventHandler: UniversalListViewControllerEventHandler?

    private let viewFactory: () -> View
    private let dataSourceController: DataSource
    private let delegateController: Delegate

    @available(*, unavailable, message: "Use programmatic init instead")
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public init(view: @escaping @autoclosure () -> View, dataSourceController: DataSource, delegateController: Delegate) {
        self.dataSourceController = dataSourceController
        self.delegateController = delegateController
        viewFactory = view
        super.init(nibName: nil, bundle: nil)
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        eventHandler?.listViewInstantiated()
    }

}

private extension UniversalListViewController {

    private func setupView() {
        let listView = viewFactory()
        listView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(listView)
        listView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        listView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        listView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        listView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }

}