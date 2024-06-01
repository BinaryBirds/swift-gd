//
//  File.swift
//
//
//  Created by Tibor Bodecs on 31/05/2024.
//

import SwiftGD
import XCTest

final class PointTests: XCTestCase {

    func testInitialization() {
        let point = Point(x: 5, y: 10)
        XCTAssertEqual(point.x, 5)
        XCTAssertEqual(point.y, 10)
    }

    func testZero() {
        let zeroPoint = Point.zero
        XCTAssertEqual(zeroPoint.x, 0)
        XCTAssertEqual(zeroPoint.y, 0)
    }

    func testEquality() {
        let point1 = Point(x: 5, y: 10)
        let point2 = Point(x: 5, y: 10)
        let point3 = Point(x: 0, y: 0)

        XCTAssertEqual(point1, point2)
        XCTAssertNotEqual(point1, point3)
    }
}
