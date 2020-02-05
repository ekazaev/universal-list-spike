//
//  WeakArray.swift
//  SaksFramework
//

import Foundation

/// Single weak object container.
private final class WeakObject {

    weak var object: AnyObject?

    init?(_ value: Any) {
        guard Mirror(reflecting: value).displayStyle == .class else {
            assertionFailure("\(value) must be an Object")
            return nil
        }

        object = value as AnyObject
    }

}

/**
 # Weak Array Collection
 A weak reference collection for **multicast delegation**.

 **Note:** *Element*s should be **non-optional** class objects, otherwise they will be ignored.
 */
public struct WeakArray<Element>: Sequence {

    fileprivate var elements: [WeakObject]

    public init(elements: [Element] = []) {
        self.elements = elements.compactMap { element in
            guard let weakObject = WeakObject(element) else {
                return nil
            }
            return weakObject
        }
    }

    /// Adds a new element at the end of the array.
    ///
    /// - Parameter newElement: The element to append to the array.
    public mutating func append(_ newElement: Element) {
        cleanUp()
        guard let weakObject = WeakObject(newElement) else {
            return
        }
        elements.append(weakObject)
    }

    /// Removes the deallocated items from the collection.
    public mutating func cleanUp() {
        elements = elements.compactMap { item in
            guard item.object != nil else { return nil }
            return item
        }
    }

    /// Returns a Boolean value indicating whether the sequence contains the
    /// given element.
    ///
    /// - Parameter element: The element to find in the sequence.
    /// - Returns: `true` if the element was found in the sequence; otherwise,
    ///   `false`.
    ///
    /// - Complexity: O(*n*), where *n* is the length of the sequence.
    public func contains(weakElement element: Element) -> Bool {
        return contains { $0 as AnyObject === element as AnyObject }
    }

    public func makeIterator() -> WeakIterator<Element> {
        return WeakIterator(weakArray: self)
    }
}

public extension WeakArray {
    mutating func appendUnique(_ element: Element) {
        cleanUp()

        guard !contains(weakElement: element) else {
            return
        }

        append(element)
    }
}

public struct WeakIterator<Element: Any>: IteratorProtocol {

    let weakArray: WeakArray<Element>

    private var index: Int

    init(weakArray: WeakArray<Element>) {
        self.weakArray = weakArray
        index = 0
    }

    public mutating func next() -> Element? {
        guard index < weakArray.elements.count else { return nil }

        if let item = weakArray.elements[index].object as? Element {
            index += 1
            return item
        }

        index += 1
        return next()
    }

}
