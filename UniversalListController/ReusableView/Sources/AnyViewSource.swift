//
// AnyViewSource.swift
// UniversalListController
//

import Foundation
import UIKit

final class AnyViewSource: ViewSource {

    typealias View = UIView

    private(set) var viewAccessMethod: () -> UIView

    lazy var view: UIView = {
        return viewAccessMethod()
    }()

    init<VS: ViewSource>(with viewSource: VS) {
        viewAccessMethod = { viewSource.view }
    }
}
