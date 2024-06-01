//
//  File.swift
//
//
//  Created by Tibor Bodecs on 01/06/2024.
//

import SwiftGD
import XCTest

final class LineTests: XCTestCase {

    func testInitialization() {
        let startPoint = Point(x: 0, y: 0)
        let endPoint = Point(x: 10, y: 10)
        let line = Line(from: startPoint, to: endPoint)

        XCTAssertEqual(line.from, startPoint)
        XCTAssertEqual(line.to, endPoint)
    }

    func testEquality() {
        let startPoint1 = Point(x: 0, y: 0)
        let endPoint1 = Point(x: 10, y: 10)
        let line1 = Line(from: startPoint1, to: endPoint1)

        let startPoint2 = Point(x: 0, y: 0)
        let endPoint2 = Point(x: 10, y: 10)
        let line2 = Line(from: startPoint2, to: endPoint2)

        XCTAssertEqual(line1, line2)
    }

    func testInequality() {
        let startPoint1 = Point(x: 0, y: 0)
        let endPoint1 = Point(x: 10, y: 10)
        let line1 = Line(from: startPoint1, to: endPoint1)

        let startPoint2 = Point(x: 1, y: 1)
        let endPoint2 = Point(x: 11, y: 11)
        let line2 = Line(from: startPoint2, to: endPoint2)

        XCTAssertNotEqual(line1, line2)
    }
}
