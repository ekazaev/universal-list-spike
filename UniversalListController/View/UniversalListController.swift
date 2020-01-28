//
// CitiesViewController.swift
// UniversalListController
//

import Foundation
import UIKit

protocol ListViewProvider {

    associatedtype ListView: UIView

    var listView: ListView { get }

}

class TableViewProvider: ListViewProvider {

    lazy var listView: UITableView = {
        return UITableView()
    }()

    init() {}

}

struct AnyViewProvider: ListViewProvider {
    private(set) var listView: UIView

    init<VP: ListViewProvider>(for viewProvider: VP) {
        listView = viewProvider.listView
    }
}

class UniversalListController: UIViewController {

    private let viewProvider: AnyViewProvider
    private let eventHandler: Any

    @available(*, unavailable, message: "Use programmatic init instead")
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init<VP: ListViewProvider>(viewProvider: VP, eventHandler: Any) {
        self.eventHandler = eventHandler
        self.viewProvider = AnyViewProvider(for: viewProvider)
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

}

private extension UniversalListController {

    private func setupView() {
        let listView = viewProvider.listView
        listView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(listView)
        listView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        listView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        listView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        listView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }

}
