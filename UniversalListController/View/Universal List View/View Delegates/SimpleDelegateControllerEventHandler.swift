//
// SimpleDelegateControllerEventHandler.swift
// UniversalListController
//

import Foundation
import UIKit

protocol SimpleDelegateControllerEventHandler: AnyObject {

    func didSelectRow(at indexPath: IndexPath)

}
