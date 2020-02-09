//
// Created by Eugene Kazaev on 09/02/2020.
// Copyright (c) 2020 Eugene Kazaev. All rights reserved.
//

import Foundation

public enum ListCellType<Data, Accessory> {

    case dataCell(Data)

    case accessoryCell(Accessory)

}
