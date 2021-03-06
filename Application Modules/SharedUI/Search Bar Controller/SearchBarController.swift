//
// SearchBarController.swift
// UniversalListController
//

import Core
import Foundation
import ReusableView
import UIKit

public protocol SearchBarControllerDelegate: AnyObject {

    func search(for query: String)

}

public final class SearchBarController: NSObject, UISearchBarDelegate {

    private var delegates = WeakArray<SearchBarControllerDelegate>()

    private var previousQuery = ""

    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let mainQueue = DispatchQueue.main
        let deadline = DispatchTime.now() + .milliseconds(500)
        mainQueue.asyncAfter(deadline: deadline) { [weak self] in
            guard let self = self,
                let query = searchBar.text?.trimmingCharacters(in: CharacterSet.whitespaces),
                query != self.previousQuery else {
                    return
            }
            self.previousQuery = query
            self.delegates.forEach { $0.search(for: query) }
        }
    }

    public func add(delegate: SearchBarControllerDelegate) {
        delegates.appendUnique(delegate)
    }

}
