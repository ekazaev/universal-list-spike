//
// SimpleTableViewDelegate.swift
// UniversalListController
//

import Foundation
import UIKit

final class SimpleTableViewDelegateController: NSObject, ReusableViewListDelegateController, UITableViewDelegate {

    typealias View = UITableView

    private let eventHandler: SimpleDelegateControllerEventHandler?

    init(eventHandler: SimpleDelegateControllerEventHandler? = nil) {
        self.eventHandler = eventHandler
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        eventHandler?.didSelectRow(at: indexPath)
    }

}
