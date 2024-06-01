//
//  File.swift
//
//
//  Created by Tibor Bodecs on 31/05/2024.
//

/// Extension for `FloatingPoint` to add computed properties for converting between radians and degrees.
extension FloatingPoint {

    /// Converts a value from degrees to radians.
    ///
    /// This computed property returns the value in radians for a given value in degrees.
    var degreesToRadians: Self {
        self * .pi / 180
    }

    /// Converts a value from radians to degrees.
    ///
    /// This computed property returns the value in degrees for a given value in radians.
    var radiansToDegrees: Self {
        self * 180 / .pi
    }
}
