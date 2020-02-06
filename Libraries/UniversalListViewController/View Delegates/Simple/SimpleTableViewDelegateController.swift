//
// SimpleTableViewDelegate.swift
// UniversalListController
//

import Foundation
import UIKit

public final class SimpleTableViewDelegateController: NSObject, UniversalListDelegateController, UITableViewDelegate {

    public typealias View = UITableView

    private let eventHandler: SimpleDelegateControllerEventHandler?

    public init(eventHandler: SimpleDelegateControllerEventHandler? = nil) {
        self.eventHandler = eventHandler
    }

    public func tableView(_ tableView: UITableView,
                          didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        eventHandler?.didSelectRow(at: indexPath)
    }

}
