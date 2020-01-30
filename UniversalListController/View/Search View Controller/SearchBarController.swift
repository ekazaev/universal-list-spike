//
// SearchBarController.swift
// UniversalListController
//

import Foundation
import UIKit

protocol SearchBarControllerDelegate: AnyObject {

    func search(for query: String)

}

final class SearchBarController: NSObject, UISearchBarDelegate {

    public weak var delegate: SearchBarControllerDelegate?

    private var previousQuery = ""

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let mainQueue = DispatchQueue.main
        let deadline = DispatchTime.now() + .milliseconds(500)
        mainQueue.asyncAfter(deadline: deadline) { [weak self] in
            guard let self = self,
                let delegate = self.delegate,
                let query = searchBar.text?.trimmingCharacters(in: CharacterSet.whitespaces),
                query != self.previousQuery else {
                    return
            }
            self.previousQuery = query
            delegate.search(for: query)
        }
    }
}
