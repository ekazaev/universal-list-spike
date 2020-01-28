//
//  ViewController.swift
//  UniversalListController
//
//  Created by Eugene Kazaev on 27/01/2020.
//  Copyright © 2020 Eugene Kazaev. All rights reserved.
//

import DifferenceKit
import UIKit

protocol UniversalListView {

    associatedtype Display

    func update(with display: Display)

}

protocol UniversalListViewEventHandler {}

// class ViewController: UIViewController {
//
//    private var dataSource: TableViewDataSource<Void, FlatCellSource<CityTableCell>>!
//
//    private var eventHandler: RandomDataEventHandler!
//
//    private var viewUpdater: DifferentiableTableViewUpdater<FlatCellSource<CityTableCell>>!
//
//    @IBOutlet private var tableView: UITableView! {
//        didSet {
//            dataSource = TableViewDataSource(viewProvider: viewProvider)
//            tableView.delegate = self
//            tableView.dataSource = dataSource
//            viewUpdater = DifferentiableTableViewUpdater(dataSource: dataSource)
//            dataSource.setup(for: tableView)
//            viewUpdater.setup(for: tableView)
//        }
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        eventHandler = RandomDataEventHandler(view: self)
//        tableView.reloadData()
//    }
//
// }
//
// extension ViewController: UniversalListView {
//
//    func update(with citiesList: [City]) {
//        let converter = FlatDataConverter<[[City]], CityTableCell>()
//        let data = converter.transform(data: [citiesList])
//        viewUpdater.update(with: data)
//    }
//
// }
//
// extension ViewController: UITableViewDelegate {}
