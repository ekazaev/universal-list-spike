//
// SimpleDelegateControllerEventHandler.swift
// UniversalListController
//

import Foundation
import UIKit

public protocol SimpleDelegateControllerEventHandler: AnyObject {

    func didSelectRow(at indexPath: IndexPath)

}
