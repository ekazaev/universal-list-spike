//
// AnyViewSource.swift
// UniversalListController
//

import Foundation
import UIKit

final class AnyViewSource: ViewSource {

    typealias View = UIView

    lazy var isViewLoaded: Bool = {
        return box.isViewLoaded
    }()

    lazy var view: UIView = {
        return box.view
    }()

    private var box: AnyViewSourceBox

    init<VS: ViewSource>(with viewSource: VS) {
        box = ViewSourceBox(with: viewSource)
    }
}

private protocol AnyViewSourceBox {

    var isViewLoaded: Bool { get }

    var view: UIView { get }

}

private final class ViewSourceBox<VS: ViewSource>: AnyViewSourceBox {

    private var viewSource: VS

    var isViewLoaded: Bool {
        return viewSource.isViewLoaded
    }

    var view: UIView {
        return viewSource.view
    }

    init(with viewSource: VS) {
        self.viewSource = viewSource
    }

}
