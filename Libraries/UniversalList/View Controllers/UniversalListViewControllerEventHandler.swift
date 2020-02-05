//
// UniversalListViewControllerDelegate.swift
// UniversalListController
//

import Foundation

public protocol UniversalListViewControllerEventHandler: AnyObject {

    func listViewInstantiated()

}

/// Extension that makes implementation optional
public extension UniversalListViewControllerEventHandler {

    func listViewInstantiated() {}

}
