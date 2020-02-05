//
// Created by Eugene Kazaev on 03/02/2020.
// Copyright (c) 2020 Eugene Kazaev. All rights reserved.
//

import Core
import Foundation
import UIKit

protocol SearchContainerViewControllerEventHandler: SearchBarControllerDelegate {}

class SearchResultsContainerViewController: UIViewController, SearchBarControllerDelegate, SearchResultStateDelegate {

    let eventHandler: SearchContainerViewControllerEventHandler

    var selectedIndex: Int = 0 {
        didSet {
            containerController.selectedIndex = selectedIndex
        }
    }

    var viewControllers: [UIViewController] = [] {
        didSet {
            containerController.viewControllers = viewControllers
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

    func searchResultStateChanged(to state: SearchResultState) {
        switch state {
        case .initial:
            if containerController.selectedIndex == 2 {
                containerController.selectedIndex = 1
            }
        case .someResults:
            containerController.selectedIndex = 1
        case .noResults:
            containerController.selectedIndex = 2
        }
    }

    func search(for query: String) {
        eventHandler.search(for: query)
    }

}
