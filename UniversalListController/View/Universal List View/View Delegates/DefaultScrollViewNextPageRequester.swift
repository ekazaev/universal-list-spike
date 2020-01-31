//
// DefaultScrollViewNextPageRequester.swift
// UniversalListController
//

import Foundation
import UIKit

protocol NextPageEventHandler {

    func requestNewPage()

}

protocol ScrollViewNextPageRequester {

    func scrollViewDidScroll(_ scrollView: UIScrollView)

}

final class DefaultScrollViewNextPageRequester: ScrollViewNextPageRequester {

    let nextPageEventInset: CGFloat

    private var eventHandler: NextPageEventHandler

    init(nextPageEventInset: CGFloat,
         eventHandler: NextPageEventHandler) {
        self.nextPageEventInset = nextPageEventInset
        self.eventHandler = eventHandler
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let viewPortHeight = scrollView.bounds.height + scrollView.contentInset.top + scrollView.contentInset.bottom
        if scrollView.contentOffset.y > scrollView.contentSize.height - viewPortHeight {
            eventHandler.requestNewPage()
        }
    }

}
