//
// ViewSource.swift
// UniversalListController
//

import Foundation
import UIKit

protocol ViewSource {

    associatedtype View: UIView

    var view: View { get }

}
