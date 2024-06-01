//
//  File.swift
//
//
//  Created by Tibor Bodecs on 31/05/2024.
//

import SwiftGD
import XCTest

/// Test cases for the `Rect` struct.
final class RectTests: XCTestCase {

    func testInitializationWithPointAndSize() {
        let point = Point(x: 10, y: 20)
        let size = Size(width: 100, height: 200)
        let rect = Rect(point: point, size: size)

        XCTAssertEqual(rect.point, point)
        XCTAssertEqual(rect.size, size)
    }

    func testInitializationWithCoordinates() {
        let rect = Rect(x: 10, y: 20, width: 100, height: 200)

        XCTAssertEqual(rect.point, Point(x: 10, y: 20))
        XCTAssertEqual(rect.size, Size(width: 100, height: 200))
    }

    func testZeroRect() {
        let zeroRect = Rect.zero

        XCTAssertEqual(zeroRect.point, Point.zero)
        XCTAssertEqual(zeroRect.size, Size.zero)
    }

    func testEquality() {
        let rect1 = Rect(x: 10, y: 20, width: 100, height: 200)
        let rect2 = Rect(x: 10, y: 20, width: 100, height: 200)
        let rect3 = Rect(x: 5, y: 10, width: 50, height: 100)

        XCTAssertEqual(rect1, rect2)
        XCTAssertNotEqual(rect1, rect3)
    }
}
