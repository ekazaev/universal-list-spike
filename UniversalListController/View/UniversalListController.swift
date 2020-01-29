//
// CitiesViewController.swift
// UniversalListController
//

import Foundation
import UIKit

class UniversalListController: UIViewController {

    private let viewFactory: AnyViewFactory
    private let eventHandler: Any

    @available(*, unavailable, message: "Use programmatic init instead")
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init<VP: ViewFactory>(factory: VP, eventHandler: Any) {
        self.eventHandler = eventHandler
        viewFactory = AnyViewFactory(with: factory)
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

}

private extension UniversalListController {

    private func setupView() {
        let listView = viewFactory.build()
        listView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(listView)
        listView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        listView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        listView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        listView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }

}
