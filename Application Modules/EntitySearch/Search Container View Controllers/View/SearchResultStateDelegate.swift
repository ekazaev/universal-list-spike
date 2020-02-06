//
// SearchStateDelegate.swift
// UniversalListController
//

import Foundation

protocol SearchResultStateDelegate: AnyObject {

    func searchResultStateChanged(to state: SearchResultState)

}
