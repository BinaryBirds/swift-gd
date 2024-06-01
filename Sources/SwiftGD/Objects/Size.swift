//
//  File.swift
//
//
//  Created by Tibor Bodecs on 31/05/2024.
//

/// A structure representing a size in a 2D space.
///
/// The `Size` struct provides a representation of a size using width and height dimensions.
public struct Size: Comparable {

    /// A size with zero width and height.
    public static let zero = Size(width: 0, height: 0)

    /// The width dimension of the size.
    public var width: Int

    /// The height dimension of the size.
    public var height: Int

    /// Initializes a new `Size` instance with the specified width and height dimensions.
    ///
    /// - Parameters:
    ///   - width: The width dimension of the size, specified as an `Int`.
    ///   - height: The height dimension of the size, specified as an `Int`.
    public init(width: Int, height: Int) {
        self.width = width
        self.height = height
    }

    /// Compares two `Size` instances to determine if one is smaller than the other.
    ///
    /// A `Size` is considered smaller if both its width and height are less than the other `Size`.
    ///
    /// - Parameters:
    ///   - lhs: A `Size` instance on the left-hand side of the comparison.
    ///   - rhs: A `Size` instance on the right-hand side of the comparison.
    /// - Returns: `true` if `lhs` is smaller than `rhs` in both dimensions, otherwise `false`.
    public static func < (lhs: Size, rhs: Size) -> Bool {
        lhs.width < rhs.width && lhs.height < rhs.height
    }
}
