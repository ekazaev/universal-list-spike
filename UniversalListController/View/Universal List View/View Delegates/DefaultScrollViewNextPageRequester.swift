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

protocol DataLoadingStateHandler {

    var isDataLoading: Bool { get }

}

final class DefaultScrollViewNextPageRequester: ScrollViewNextPageRequester {

    let nextPageEventInset: CGFloat

    private var nextPageEventHandler: NextPageEventHandler

    private var loadingStateEventHandler: DataLoadingStateHandler

    init(nextPageEventInset: CGFloat,
         nextPageEventHandler: NextPageEventHandler,
         loadingStateEventHandler: DataLoadingStateHandler) {
        self.nextPageEventInset = nextPageEventInset
        self.nextPageEventHandler = nextPageEventHandler
        self.loadingStateEventHandler = loadingStateEventHandler
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard !loadingStateEventHandler.isDataLoading else {
            return
        }

        let viewPortHeight = scrollView.bounds.height // + scrollView.contentInset.top + scrollView.contentInset.bottom
        if scrollView.contentOffset.y > scrollView.contentSize.height - viewPortHeight {
            nextPageEventHandler.requestNewPage()
        }
    }

}
