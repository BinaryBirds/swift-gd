//
//  File.swift
//
//
//  Created by Tibor Bodecs on 31/05/2024.
//

import SwiftGD
import XCTest

final class SizeTests: XCTestCase {

    func testInitialization() {
        let size = Size(width: 100, height: 200)
        XCTAssertEqual(size.width, 100)
        XCTAssertEqual(size.height, 200)
    }

    func testZero() {
        let zeroSize = Size.zero
        XCTAssertEqual(zeroSize.width, 0)
        XCTAssertEqual(zeroSize.height, 0)
    }

    func testEquality() {
        let size1 = Size(width: 100, height: 200)
        let size2 = Size(width: 100, height: 200)
        let size3 = Size(width: 150, height: 250)

        XCTAssertEqual(size1, size2)
        XCTAssertNotEqual(size1, size3)
    }

    func testComparison() {
        let size1 = Size(width: 100, height: 200)
        let size2 = Size(width: 150, height: 250)
        let size3 = Size(width: 50, height: 100)

        XCTAssertTrue(size1 < size2)
        XCTAssertFalse(size2 < size1)
        XCTAssertTrue(size3 < size1)
        XCTAssertFalse(size1 < size3)
    }
}
