//
// SimpleTableViewDelegate.swift
// UniversalListController
//

import Foundation
import UIKit

public final class SimpleTableViewDelegateController: NSObject, UniversalListDelegateController, UITableViewDelegate {

    public typealias View = UITableView

    private let nextPageRequester: ScrollViewNextPageRequester?

    private let eventHandler: SimpleDelegateControllerEventHandler?

    public init(nextPageRequester: ScrollViewNextPageRequester? = nil,
                eventHandler: SimpleDelegateControllerEventHandler? = nil) {
        self.eventHandler = eventHandler
        self.nextPageRequester = nextPageRequester
    }

    public func tableView(_ tableView: UITableView,
                          didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        eventHandler?.didSelectRow(at: indexPath)
    }

    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        nextPageRequester?.scrollViewDidScroll(scrollView)
    }

}
