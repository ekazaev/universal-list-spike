//
// UniversalListViewController.swift
// UniversalListController
//

import Core
import Foundation
import UIKit

public final class UniversalListViewController<View, DataSource: UniversalListDataSourceController, Delegate: UniversalListDelegateController>: UIViewController
    where
    View == DataSource.View,
    View == Delegate.View {

    public let eventHandler: UniversalListViewControllerEventHandler

    private let viewFactory: () -> View
    private let dataSourceController: DataSource
    private let delegateController: Delegate

    @available(*, unavailable, message: "Use programmatic init instead")
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public init(view: @escaping @autoclosure () -> View,
                eventHandler: UniversalListViewControllerEventHandler,
                dataSourceController: DataSource, delegateController: Delegate) {
        self.dataSourceController = dataSourceController
        self.delegateController = delegateController
        self.eventHandler = eventHandler
        viewFactory = view
        super.init(nibName: nil, bundle: nil)
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        eventHandler.listViewInstantiated()
    }

}

private extension UniversalListViewController {

    private func setupView() {
        let listView = viewFactory()
        view.addSubview(listView)
        listView.addConstraints(equalToSuperview())
    }

}
