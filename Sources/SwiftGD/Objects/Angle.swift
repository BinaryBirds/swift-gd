//
//  File.swift
//
//
//  Created by Tibor Bodecs on 31/05/2024.
//

/// A structure representing an angle, which can be expressed in both radians and degrees.
///
/// Conforms to the `Equatable` protocol.
public struct Angle: Equatable {

    /// An angle with a value of zero degrees.
    public static let zero = Angle(degrees: 0)

    /// The angle value in radians.
    public var radians: Double

    /// The angle value in degrees.
    public var degrees: Double {
        get { radians.radiansToDegrees }
        set { radians = newValue.degreesToRadians }
    }

    /// Initializes a new `Angle` instance with the specified radians value.
    ///
    /// - Parameter radians: The angle value in radians.
    public init(radians: Double) {
        self.radians = radians
    }

    /// Initializes a new `Angle` instance with the specified degrees value.
    ///
    /// - Parameter degrees: The angle value in degrees.
    public init(degrees: Double) {
        self.init(radians: degrees.degreesToRadians)
    }
}
