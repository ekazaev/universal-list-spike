//
// Created by Eugene Kazaev on 06/02/2020.
// Copyright (c) 2020 Eugene Kazaev. All rights reserved.
//

import Foundation
import ReusableView

public protocol DataProvidingCell: ReusableView {

    associatedtype Data

    func getData() -> Data?

}
