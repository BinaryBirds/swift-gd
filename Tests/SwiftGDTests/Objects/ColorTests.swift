//
//  File.swift
//
//
//  Created by Tibor Bodecs on 31/05/2024.
//

import SwiftGD
import XCTest

final class ColorTests: XCTestCase {

    func testInitialization() {
        let color = Color(red: 0.5, green: 0.4, blue: 0.3, alpha: 0.8)
        XCTAssertEqual(color.red, 0.5)
        XCTAssertEqual(color.green, 0.4)
        XCTAssertEqual(color.blue, 0.3)
        XCTAssertEqual(color.alpha, 0.8)
    }

    func testEquality() {
        let color1 = Color(red: 0.1, green: 0.2, blue: 0.3, alpha: 0.4)
        let color2 = Color(red: 0.1, green: 0.2, blue: 0.3, alpha: 0.4)
        let color3 = Color(red: 0.5, green: 0.6, blue: 0.7, alpha: 0.8)

        XCTAssertEqual(color1, color2)
        XCTAssertNotEqual(color1, color3)
    }
}
