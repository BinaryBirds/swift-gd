//
//  File.swift
//
//
//  Created by Tibor Bodecs on 01/06/2024.
//

/// A structure representing an ellipse in a 2D coordinate system.
///
/// The `Ellipse` struct provides a representation of an ellipse using a center point and size.
public struct Ellipse: Equatable {

    /// The center point of the ellipse.
    public var center: Point

    /// The size of the ellipse.
    public var size: Size

    /// Initializes a new ellipse with the specified center point and size.
    ///
    /// - Parameters:
    ///   - center: The center point of the ellipse.
    ///   - size: The size of the ellipse.
    public init(center: Point, size: Size) {
        self.center = center
        self.size = size
    }
}
