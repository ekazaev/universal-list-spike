//
// SearchListDelegate.swift
// UniversalListController
//

import Foundation
import UIKit

protocol SearchListDelegateEventHandler {

    func didSelect(city: City)

}

final class CitySearchTableDelegateTransformer: NSObject, UITableViewDelegate {

    let eventHandler: SearchListDelegateEventHandler

    init(eventHandler: SearchListDelegateEventHandler) {
        self.eventHandler = eventHandler
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? CityTableCell, let city = cell.city else {
            return
        }
        eventHandler.didSelect(city: city)
        tableView.deselectRow(at: indexPath, animated: true)
    }

}
