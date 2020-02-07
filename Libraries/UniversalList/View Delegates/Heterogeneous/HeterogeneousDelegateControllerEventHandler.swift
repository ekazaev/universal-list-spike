//
// Created by Eugene Kazaev on 06/02/2020.
// Copyright (c) 2020 Eugene Kazaev. All rights reserved.
//

import Foundation

public protocol HeterogeneousDelegateControllerEventHandler {

    associatedtype Data

    func didSelectRow(at indexPath: IndexPath, with data: Data?)

    func didSelectNonHeterogeneousRow(at indexPath: IndexPath)

}
