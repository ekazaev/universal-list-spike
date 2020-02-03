//
// Created by Eugene Kazaev on 03/02/2020.
// Copyright (c) 2020 Eugene Kazaev. All rights reserved.
//

import Foundation
import UIKit

class ContainerViewController: UIViewController {

    var selectedIndex: Int {
        get {
            return containerController.selectedIndex
        }
        set {
            containerController.selectedIndex = newValue
        }
    }

    var viewControllers: [UIViewController] {
        get {
            return containerController.viewControllers
        }
        set {
            containerController.viewControllers = newValue
        }
    }

    private lazy var containerController = {
        return ContainerController(for: self)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        containerController.setup()
    }

}
