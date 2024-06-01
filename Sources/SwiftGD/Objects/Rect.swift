//
//  File.swift
//
//
//  Created by Tibor Bodecs on 31/05/2024.
//

/// A structure representing a rectangle in a 2D space.
///
/// The `Rect` struct provides a representation of a rectangle using a starting point and a size.
public struct Rect: Equatable {

    /// A rectangle with zero point and size.
    public static let zero = Rect(point: .zero, size: .zero)

    /// The starting point of the rectangle.
    public var point: Point

    /// The size of the rectangle.
    public var size: Size

    /// Initializes a new `Rect` instance with the specified point and size.
    ///
    /// - Parameters:
    ///   - point: The starting point of the rectangle, specified as a `Point`.
    ///   - size: The size of the rectangle, specified as a `Size`.
    public init(point: Point, size: Size) {
        self.point = point
        self.size = size
    }

    /// Initializes a new `Rect` instance with the specified x, y, width, and height.
    ///
    /// - Parameters:
    ///   - x: The x-coordinate of the rectangle's starting point, specified as an `Int`.
    ///   - y: The y-coordinate of the rectangle's starting point, specified as an `Int`.
    ///   - width: The width of the rectangle, specified as an `Int`.
    ///   - height: The height of the rectangle, specified as an `Int`.
    public init(
        x: Int,
        y: Int,
        width: Int,
        height: Int
    ) {
        self.init(
            point: .init(x: x, y: y),
            size: .init(
                width: width,
                height: height
            )
        )
    }
}
