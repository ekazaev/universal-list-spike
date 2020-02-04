//
// UniversalListViewControllerDelegate.swift
// UniversalListController
//

import Foundation

protocol UniversalListViewControllerEventHandler: AnyObject {

    func listViewInstantiated()

}

/// Extension that makes implementation optional
extension UniversalListViewControllerEventHandler {

    func listViewInstantiated() {}

}
