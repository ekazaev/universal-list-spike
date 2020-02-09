//
// DefaultScrollViewNextPageRequester.swift
// UniversalListController
//

import Foundation
import UIKit

public protocol NextPageEventHandler {

    func requestNewPage()

}

public protocol DataLoadingSource {

    var shouldRequestNextPage: Bool { get }

}

public extension DataLoadingSource {

    var shouldRequestNextPage: Bool {
        return true
    }

}

public final class DefaultScrollViewNextPageRequester: NSObject, UIScrollViewDelegate {

    public let nextPageEventInset: CGFloat

    private var nextPageEventHandler: NextPageEventHandler

    private var loadingStateSource: DataLoadingSource

    public init(nextPageEventInset: CGFloat,
                nextPageEventHandler: NextPageEventHandler,
                loadingStateSource: DataLoadingSource) {
        self.nextPageEventInset = nextPageEventInset
        self.nextPageEventHandler = nextPageEventHandler
        self.loadingStateSource = loadingStateSource
    }

    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard loadingStateSource.shouldRequestNextPage else {
            return
        }

        let viewPortHeight = scrollView.bounds.height // + scrollView.contentInset.top + scrollView.contentInset.bottom
        if scrollView.contentOffset.y > scrollView.contentSize.height - viewPortHeight {
            nextPageEventHandler.requestNewPage()
        }
    }

}
