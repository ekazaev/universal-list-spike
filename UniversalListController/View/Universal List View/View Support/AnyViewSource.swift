//
// AnyViewSource.swift
// UniversalListController
//

import Foundation
import UIKit

final class AnyViewSource: ListViewSource {

    typealias View = UIView

    lazy var isViewLoaded: Bool = {
        return box.isViewLoaded
    }()

    lazy var view: UIView = {
        return box.view
    }()

    private var box: AnyViewSourceBox

    init<VS: ListViewSource>(with viewSource: VS) {
        box = ViewSourceBox(with: viewSource)
    }
}

private protocol AnyViewSourceBox {

    var isViewLoaded: Bool { get }

    var view: UIView { get }

}

private final class ViewSourceBox<ViewSource: ListViewSource>: AnyViewSourceBox {

    private var viewSource: ViewSource

    var isViewLoaded: Bool {
        return viewSource.isViewLoaded
    }

    var view: UIView {
        return viewSource.view
    }

    init(with viewSource: ViewSource) {
        self.viewSource = viewSource
    }

}
