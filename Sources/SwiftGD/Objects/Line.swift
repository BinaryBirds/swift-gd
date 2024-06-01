//
//  File.swift
//
//
//  Created by Tibor Bodecs on 01/06/2024.
//

/// A structure representing a line in a 2D coordinate system.
///
/// The `Line` struct provides a representation of a line using two points: a starting point and an ending point.
public struct Line: Equatable {

    /// The starting point of the line.
    public var from: Point

    /// The ending point of the line.
    public var to: Point

    /// Initializes a new line with the specified starting and ending points.
    ///
    /// - Parameters:
    ///   - from: The starting point of the line.
    ///   - to: The ending point of the line.
    public init(from: Point, to: Point) {
        self.from = from
        self.to = to
    }
}
