//
// UniversalListViewControllerDelegate.swift
// UniversalListController
//

import Foundation

protocol UniversalListViewControllerDelegate: AnyObject {

    func listViewInstantiated()

}

/// Extension that makes implementation optional
extension UniversalListViewControllerDelegate {

    func listViewInstantiated() {}

}
