//
// SimpleTableViewDelegate.swift
// UniversalListController
//

import Foundation
import UIKit

final class SimpleTableViewDelegateController: NSObject, ReusableViewListDelegateController, UITableViewDelegate {

    typealias View = UITableView

    private let nextPageRequester: ScrollViewNextPageRequester?

    private let eventHandler: SimpleDelegateControllerEventHandler?

    init(nextPageRequester: ScrollViewNextPageRequester? = nil,
         eventHandler: SimpleDelegateControllerEventHandler? = nil) {
        self.eventHandler = eventHandler
        self.nextPageRequester = nextPageRequester
    }

    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        eventHandler?.didSelectRow(at: indexPath)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        nextPageRequester?.scrollViewDidScroll(scrollView)
    }

}
