//
//  File.swift
//
//
//  Created by Tibor Bodecs on 31/05/2024.
//

import SwiftGD
import XCTest

final class AngleTests: XCTestCase {

    func testInitializationWithDegrees() {
        let angle = Angle(degrees: 180.0)
        XCTAssertEqual(angle.degrees, 180.0, accuracy: 1e-10)
        XCTAssertEqual(angle.radians, .pi, accuracy: 1e-10)
    }

    func testInitializationWithRadians() {
        let angle = Angle(radians: .pi)
        XCTAssertEqual(angle.degrees, 180.0, accuracy: 1e-10)
        XCTAssertEqual(angle.radians, .pi, accuracy: 1e-10)
    }

    func testZeroAngle() {
        let zeroAngle = Angle.zero
        XCTAssertEqual(zeroAngle.degrees, 0.0, accuracy: 1e-10)
        XCTAssertEqual(zeroAngle.radians, 0.0, accuracy: 1e-10)
    }

    func testEquality() {
        let angle1 = Angle(degrees: 180.0)
        let angle2 = Angle(radians: .pi)
        let angle3 = Angle(degrees: 90.0)

        XCTAssertEqual(angle1, angle2)
        XCTAssertNotEqual(angle1, angle3)
    }

    func testSettingDegrees() {
        var angle = Angle(degrees: 0.0)
        angle.degrees = 90.0
        XCTAssertEqual(angle.degrees, 90.0, accuracy: 1e-10)
        XCTAssertEqual(angle.radians, .pi / 2, accuracy: 1e-10)
    }

    func testSettingRadians() {
        var angle = Angle(radians: 0.0)
        angle.radians = .pi / 2
        XCTAssertEqual(angle.degrees, 90.0, accuracy: 1e-10)
        XCTAssertEqual(angle.radians, .pi / 2, accuracy: 1e-10)
    }
}
