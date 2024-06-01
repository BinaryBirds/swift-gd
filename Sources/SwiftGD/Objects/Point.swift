//
//  File.swift
//
//
//  Created by Tibor Bodecs on 31/05/2024.
//

/// A structure representing a point in a 2D coordinate system.
///
/// The `Point` struct provides a representation of a point using x and y coordinates.
public struct Point: Equatable {

    /// A point at the origin (0, 0).
    public static let zero = Point(x: 0, y: 0)

    /// The x-coordinate of the point.
    public var x: Int

    /// The y-coordinate of the point.
    public var y: Int

    /// Initializes a new `Point` instance with the specified x and y coordinates.
    ///
    /// - Parameters:
    ///   - x: The x-coordinate of the point, specified as an `Int`.
    ///   - y: The y-coordinate of the point, specified as an `Int`.
    public init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
}
