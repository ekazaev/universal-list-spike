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

    private var viewUpdater: DifferentiableTableViewUpdater<SimpleCellSource<CityTableCell>>!

    @IBOutlet private var tableView: UITableView! {
        didSet {
            dataSource = TableViewDataSource()
            tableView.delegate = self
            tableView.dataSource = dataSource
            dataSource.setup(for: tableView)
            viewUpdater = DifferentiableTableViewUpdater(tableView: tableView, dataSource: dataSource)
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
        viewUpdater.update(with: ListData(sections: [SectionData(cells: citiesList.map { CellData(context: SimpleCellSource<CityTableCell>(with: $0)) })]))
    }

}

extension ViewController: UITableViewDelegate {}
