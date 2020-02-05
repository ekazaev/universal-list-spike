//
// DefaultScrollViewNextPageRequester.swift
// UniversalListController
//

import Foundation
import UIKit

public protocol NextPageEventHandler {

    func requestNewPage()

}

public protocol DataLoadingStateHandler {

    var isDataLoading: Bool { get }

}

public final class DefaultScrollViewNextPageRequester: ScrollViewNextPageRequester {

    public let nextPageEventInset: CGFloat

    private var nextPageEventHandler: NextPageEventHandler

    private var loadingStateEventHandler: DataLoadingStateHandler

    public init(nextPageEventInset: CGFloat,
                nextPageEventHandler: NextPageEventHandler,
                loadingStateEventHandler: DataLoadingStateHandler) {
        self.nextPageEventInset = nextPageEventInset
        self.nextPageEventHandler = nextPageEventHandler
        self.loadingStateEventHandler = loadingStateEventHandler
    }

    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard !loadingStateEventHandler.isDataLoading else {
            return
        }

        let viewPortHeight = scrollView.bounds.height // + scrollView.contentInset.top + scrollView.contentInset.bottom
        if scrollView.contentOffset.y > scrollView.contentSize.height - viewPortHeight {
            nextPageEventHandler.requestNewPage()
        }
    }

}
