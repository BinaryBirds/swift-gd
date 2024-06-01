//
//  File.swift
//
//
//  Created by Tibor Bodecs on 01/06/2024.
//

import SwiftGD
import XCTest

final class EllipseTests: XCTestCase {

    func testInitialization() {
        let center = Point(x: 10, y: 20)
        let size = Size(width: 30, height: 40)
        let ellipse = Ellipse(center: center, size: size)

        XCTAssertEqual(ellipse.center, center)
        XCTAssertEqual(ellipse.size, size)
    }

    func testEquality() {
        let center1 = Point(x: 10, y: 20)
        let size1 = Size(width: 30, height: 40)
        let ellipse1 = Ellipse(center: center1, size: size1)

        let center2 = Point(x: 10, y: 20)
        let size2 = Size(width: 30, height: 40)
        let ellipse2 = Ellipse(center: center2, size: size2)

        XCTAssertEqual(ellipse1, ellipse2)
    }

    func testInequality() {
        let center1 = Point(x: 10, y: 20)
        let size1 = Size(width: 30, height: 40)
        let ellipse1 = Ellipse(center: center1, size: size1)

        let center2 = Point(x: 15, y: 25)
        let size2 = Size(width: 35, height: 45)
        let ellipse2 = Ellipse(center: center2, size: size2)

        XCTAssertNotEqual(ellipse1, ellipse2)
    }
}
