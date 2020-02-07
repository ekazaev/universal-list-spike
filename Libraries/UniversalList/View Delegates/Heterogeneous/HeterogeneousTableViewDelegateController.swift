//
// Created by Eugene Kazaev on 06/02/2020.
// Copyright (c) 2020 Eugene Kazaev. All rights reserved.
//

import Foundation
import UIKit

public final class HeterogeneousTableViewDelegateController<Cell: DataProvidingCell, EventHandler: HeterogeneousDelegateControllerEventHandler>: NSObject, UniversalListDelegateController, UITableViewDelegate
    where Cell.Data == EventHandler.Data {

    public typealias View = UITableView

    private let eventHandler: EventHandler?

    public init(eventHandler: EventHandler? = nil) {
        self.eventHandler = eventHandler
    }

    public func tableView(_ tableView: UITableView,
                          didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let cell = tableView.cellForRow(at: indexPath),
            let heterogeneousCell = cell as? Cell else {
                eventHandler?.didSelectNonHeterogeneousRow(at: indexPath)
                return
        }
        eventHandler?.didSelectRow(at: indexPath, with: heterogeneousCell.getData())
    }

}
