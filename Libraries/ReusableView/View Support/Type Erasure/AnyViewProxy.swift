//
// AnyViewHolder.swift
// UniversalListController
//

import Foundation
import UIKit

public final class AnyViewProxy: ViewAccessProxy {

    public typealias View = UIView

    public lazy var isViewLoaded: Bool = {
        return box.isViewLoaded
    }()

    public lazy var view: UIView = {
        return box.view
    }()

    private var box: AnyViewProxyBox

    init<H: ViewAccessProxy>(with proxy: H) {
        box = ViewProxyBox(with: proxy)
    }
}

private protocol AnyViewProxyBox {

    var isViewLoaded: Bool { get }

    var view: UIView { get }

}

private final class ViewProxyBox<Proxy: ViewAccessProxy>: AnyViewProxyBox {

    private var proxy: Proxy

    var isViewLoaded: Bool {
        return proxy.isViewLoaded
    }

    var view: UIView {
        return proxy.view
    }

    init(with viewSource: Proxy) {
        proxy = viewSource
    }

}
