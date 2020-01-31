//
// AnyViewHolder.swift
// UniversalListController
//

import Foundation
import UIKit

final class AnyViewHolder: ViewHolder {

    typealias View = UIView

    lazy var isViewLoaded: Bool = {
        return box.isViewLoaded
    }()

    lazy var view: UIView = {
        return box.view
    }()

    private var box: AnyViewHolderBox

    init<H: ViewHolder>(with holder: H) {
        box = ViewHolderBox(with: holder)
    }
}

private protocol AnyViewHolderBox {

    var isViewLoaded: Bool { get }

    var view: UIView { get }

}

private final class ViewHolderBox<ViewSource: ViewHolder>: AnyViewHolderBox {

    private var holder: ViewSource

    var isViewLoaded: Bool {
        return holder.isViewLoaded
    }

    var view: UIView {
        return holder.view
    }

    init(with viewSource: ViewSource) {
        holder = viewSource
    }

}
