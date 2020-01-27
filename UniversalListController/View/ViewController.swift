//
//  ViewController.swift
//  UniversalListController
//
//  Created by Eugene Kazaev on 27/01/2020.
//  Copyright © 2020 Eugene Kazaev. All rights reserved.
//

import DifferenceKit
import UIKit

protocol UniversalListViewControllerEventHandler {}

protocol UniversalListView {

    associatedtype Display

    func update(with display: Display)

}

protocol UniversalListViewEventHandler {}

class ViewController: UIViewController {

    private var dataSource: TableViewDataSource<Void, SimpleCellSource<CityTableCell>>!

    private var eventHandler: RandomDataEventHandler!

    @IBOutlet private var tableView: UITableView! {
        didSet {
            dataSource = TableViewDataSource()
            tableView.delegate = self
            tableView.dataSource = dataSource
            dataSource.setup(for: tableView)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        eventHandler = RandomDataEventHandler(view: self)
        tableView.reloadData()
    }

}

extension ViewController: UniversalListView {

    func update(with citiesList: [City]) {
        let source = dataSource.data.getAsDifferentiableArray()
        let changeSet = StagedChangeset(source: source, target: [ArraySection(model: 0, elements: citiesList.map { SimpleCellSource<CityTableCell>(with: $0) })])
        tableView.reload(using: changeSet, with: .fade) { data in
            let sections = data.map { SectionData(cells: $0.elements.map { CellData(context: $0) }) }
            dataSource.data = ListData(sections: sections) // as ListData<Void, SimpleCellSource<CityTableCell>>
        }
    }

}

extension ViewController: UITableViewDelegate {}
