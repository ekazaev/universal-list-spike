//
// SimpleCollectionViewDelegateController.swift
// UniversalListController
//

import Foundation
import UIKit

final class SimpleCollectionViewDelegateController: NSObject, ReusableViewListDelegateController, UICollectionViewDelegate {

    typealias View = UICollectionView

    private let eventHandler: SimpleDelegateControllerEventHandler?

    init(eventHandler: SimpleDelegateControllerEventHandler? = nil) {
        self.eventHandler = eventHandler
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        eventHandler?.didSelectRow(at: indexPath)
    }

}
