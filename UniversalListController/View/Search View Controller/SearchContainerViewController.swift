//
// Created by Eugene Kazaev on 03/02/2020.
// Copyright (c) 2020 Eugene Kazaev. All rights reserved.
//

import Foundation
import UIKit

protocol SearchContainerViewControllerEventHandler: SearchBarControllerDelegate {}

class SearchContainerViewController: UIViewController, SearchBarControllerDelegate {

    let eventHandler: SearchContainerViewControllerEventHandler

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

    init(eventHandler: SearchContainerViewControllerEventHandler) {
        self.eventHandler = eventHandler
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable, message: "Use programmatic init instead")
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        containerController.setup()
    }

    func search(for query: String) {
        if query.isEmpty {
            containerController.selectedIndex = 0
        } else {
            containerController.selectedIndex = 1
        }
        eventHandler.search(for: query)
    }

}
