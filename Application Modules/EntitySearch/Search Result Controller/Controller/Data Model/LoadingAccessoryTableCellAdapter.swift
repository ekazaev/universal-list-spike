//
// Created by Eugene Kazaev on 09/02/2020.
// Copyright (c) 2020 Eugene Kazaev. All rights reserved.
//

import Foundation
import ReusableView
import Shared
import SharedUI
import UIKit

struct LoadingAccessoryTableCellAdapter: DataConfigurableCellAdapter {

    private let accessoryType: LoadingAccessory

    init(with accessoryType: LoadingAccessory) {
        self.accessoryType = accessoryType
    }

    func getView(with factory: ReusableViewFactory) -> UITableViewCell {
        switch accessoryType {
        case .pleaseWait:
            return factory.build() as SearchingTableViewCell
        case .loadingMore:
            return factory.build() as LoadingTableViewCell
        }
    }

}
