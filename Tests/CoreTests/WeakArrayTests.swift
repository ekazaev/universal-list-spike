//
//  WeakArrayTests.swift
//  SaksFrameworkTests
//

import XCTest
@testable import Core

private protocol SomeProtocol: AnyObject {
    var zoo: Int { get set }
    func foo() -> Bool
}

private class SomeClass: SomeProtocol {
    var zoo: Int
    init() {
        zoo = -1
    }

    init(zoo: Int) {
        self.zoo = zoo
    }

    func foo() -> Bool { return true }
}

class WeakArrayTests: XCTestCase {
    func testRetaininig2() {
        let view1 = UIView()
        view1.tag = 1

        let lazyArray = WeakArray(elements: [UIView(), UIView(), view1])

        let views = lazyArray.compactMap { $0 }
        XCTAssertTrue(views.count == 1)
        XCTAssertTrue(views.first!.tag == 1)
    }

    func testProtocols() {
        var weakClassProtocolArray = WeakArray<SomeProtocol>(elements: [])
        weakClassProtocolArray.append(SomeClass())
        let someClass2 = SomeClass()
        weakClassProtocolArray.append(someClass2)

        let classInstances = weakClassProtocolArray.compactMap { $0 }
        XCTAssertTrue(classInstances.count == 1)
        XCTAssertTrue(classInstances.first!.foo())
    }

    func testDeletedObjects() {
        var someClass1: SomeClass? = SomeClass()
        let someClass2: SomeClass = SomeClass()
        let weakArray = WeakArray<SomeProtocol>(elements: [someClass1!, someClass2])
        var weakArrayFiltered: [SomeProtocol]? = weakArray.compactMap { $0 }
        XCTAssertTrue(weakArrayFiltered!.count == 2)
        weakArrayFiltered = nil
        someClass1 = nil
        weakArrayFiltered = weakArray.compactMap { $0 }
        XCTAssertTrue(weakArrayFiltered!.count == 1)
    }

    func testCleanUp() {
        var var1: SomeClass? = SomeClass()
        let var2 = SomeClass()

        var weakArray = WeakArray<SomeProtocol>(elements: [var1!, var2])
        var1 = nil
        let var3 = SomeClass()
        weakArray.append(var3)

        weakArray.cleanUp()

        XCTAssertTrue(weakArray.compactMap { $0 }.count == 2)
        XCTAssertTrue(weakArray.compactMap { $0 }.first! === var2)
        XCTAssertTrue(weakArray.compactMap { $0 }[1] === var3)
    }

    func testContains() {
        var var1: SomeClass? = SomeClass()
        let var2 = SomeClass()
        var weakArray = WeakArray<SomeProtocol>(elements: [var1!, var2])

        XCTAssertTrue(weakArray.contains { $0 === var1 })
        XCTAssertTrue(weakArray.contains(weakElement: var1!))

        var1 = nil
        weakArray.cleanUp()
        XCTAssertFalse(weakArray.contains { $0 === var1 })
    }

    func testStressCase() {
        var var00: SomeClass? = SomeClass()
        var00?.zoo = 0
        let var01: SomeClass = SomeClass()
        var01.zoo = 1
        var var02: SomeClass? = SomeClass()
        var02?.zoo = 2
        let var03: SomeClass = SomeClass()
        var03.zoo = 3
        var var04: SomeClass? = SomeClass()
        var04?.zoo = 4
        let var05: SomeClass = SomeClass()
        var05.zoo = 5
        var var06: SomeClass? = SomeClass()
        var06?.zoo = 6
        let var07: SomeClass = SomeClass()
        var07.zoo = 7
        var var08: SomeClass? = SomeClass()
        var08?.zoo = 8
        let var09: SomeClass = SomeClass()
        var09.zoo = 9
        var var10: SomeClass? = SomeClass()
        var10?.zoo = 10
        let var11: SomeClass = SomeClass()
        var11.zoo = 11
        var var12: SomeClass? = SomeClass()
        var12?.zoo = 12
        let var13: SomeClass = SomeClass()
        var13.zoo = 13
        var var14: SomeClass? = SomeClass()
        var14?.zoo = 14
        let var15: SomeClass = SomeClass()
        var15.zoo = 15
        var var16: SomeClass? = SomeClass()
        var16?.zoo = 16
        let var17: SomeClass = SomeClass()
        var17.zoo = 17
        var var18: SomeClass? = SomeClass()
        var18?.zoo = 18
        let var19: SomeClass = SomeClass()
        var19.zoo = 19

        var weakArray =
            WeakArray<SomeProtocol>(elements: [var00!, var01, var02!, var03, var04!, var05, var06!, var07, var08!, var09])
        weakArray.append(var10!)
        weakArray.append(var11)
        weakArray.append(var12!)
        weakArray.append(var13)
        weakArray.append(var14!)
        weakArray.append(var15)
        weakArray.append(var16!)
        weakArray.append(var17)
        weakArray.append(var18!)
        weakArray.append(var19)

        XCTAssertTrue(weakArray.compactMap { $0 }.count == 20)
        weakArray.forEach {
            XCTAssertTrue($0.zoo >= 0)
            XCTAssertTrue($0.zoo < 20)
        }

        XCTAssertTrue(weakArray.contains(weakElement: var00!))
        XCTAssertTrue(weakArray.contains(weakElement: var01))
        XCTAssertTrue(weakArray.contains(weakElement: var02!))
        XCTAssertTrue(weakArray.contains(weakElement: var03))
        XCTAssertTrue(weakArray.contains(weakElement: var04!))
        XCTAssertTrue(weakArray.contains(weakElement: var05))
        XCTAssertTrue(weakArray.contains(weakElement: var06!))
        XCTAssertTrue(weakArray.contains(weakElement: var07))
        XCTAssertTrue(weakArray.contains(weakElement: var08!))
        XCTAssertTrue(weakArray.contains(weakElement: var09))
        XCTAssertTrue(weakArray.contains(weakElement: var10!))
        XCTAssertTrue(weakArray.contains(weakElement: var11))
        XCTAssertTrue(weakArray.contains(weakElement: var12!))
        XCTAssertTrue(weakArray.contains(weakElement: var13))
        XCTAssertTrue(weakArray.contains(weakElement: var14!))
        XCTAssertTrue(weakArray.contains(weakElement: var15))
        XCTAssertTrue(weakArray.contains(weakElement: var16!))
        XCTAssertTrue(weakArray.contains(weakElement: var17))
        XCTAssertTrue(weakArray.contains(weakElement: var18!))
        XCTAssertTrue(weakArray.contains(weakElement: var19))

        var00 = nil
        var02 = nil
        var04 = nil
        var06 = nil
        var08 = nil
        var10 = nil
        var12 = nil
        var14 = nil
        var16 = nil
        var18 = nil

        XCTAssertTrue(weakArray.compactMap { $0 }.count == 10)
        weakArray.forEach { XCTAssertTrue($0.zoo % 2 == 1) }

        XCTAssertTrue(weakArray.contains(weakElement: var01))
        XCTAssertTrue(weakArray.contains(weakElement: var03))
        XCTAssertTrue(weakArray.contains(weakElement: var05))
        XCTAssertTrue(weakArray.contains(weakElement: var07))
        XCTAssertTrue(weakArray.contains(weakElement: var09))
        XCTAssertTrue(weakArray.contains(weakElement: var11))
        XCTAssertTrue(weakArray.contains(weakElement: var13))
        XCTAssertTrue(weakArray.contains(weakElement: var15))
        XCTAssertTrue(weakArray.contains(weakElement: var17))
        XCTAssertTrue(weakArray.contains(weakElement: var19))
    }
}
