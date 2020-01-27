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

protocol UniversalListViewEventHandler {


}

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
        switch dataSource.data.sections.count {
        case 0:
            dataSource.data = ListData(sections: [SectionData(cells: citiesList.map { CellData(context: SimpleCellSource<CityTableCell>(with: $0)) })])
            tableView.reloadData()
        default:
            let source = dataSource.data.sections[0].cells.map { $0.context.data }
            let changeSet = StagedChangeset(source: source, target: citiesList)
            tableView.reload(using: changeSet, with: .fade) { data in
                dataSource.data = ListData(sections: [SectionData(cells: data.map { CellData(context: SimpleCellSource<CityTableCell>(with: $0)) })])
            }
        }
    }

}

extension ViewController: UITableViewDelegate {}
