//
//  File.swift
//
//
//  Created by Tibor Bodecs on 31/05/2024.
//

/// A structure representing a color in the RGBA color space.
///
/// The `Color` struct provides a representation of a color using the RGBA (Red, Green, Blue, Alpha) color model.
public struct Color: Equatable {

    /// Predefined color representing red with full opacity.
    public static let red = Color(red: 1, green: 0, blue: 0, alpha: 1)

    /// Predefined color representing green with full opacity.
    public static let green = Color(red: 0, green: 1, blue: 0, alpha: 1)

    /// Predefined color representing blue with full opacity.
    public static let blue = Color(red: 0, green: 0, blue: 1, alpha: 1)

    /// Predefined color representing cyan with full opacity.
    public static let cyan = Color(red: 0, green: 1, blue: 1, alpha: 1)

    /// Predefined color representing yellow with full opacity.
    public static let yellow = Color(red: 1, green: 1, blue: 0, alpha: 1)

    /// Predefined color representing magenta with full opacity.
    public static let magenta = Color(red: 1, green: 0, blue: 1, alpha: 1)

    /// Predefined color representing black with full opacity.
    public static let black = Color(red: 0, green: 0, blue: 0, alpha: 1)

    /// Predefined color representing white with full opacity.
    public static let white = Color(red: 1, green: 1, blue: 1, alpha: 1)

    // MARK: -

    /// The red component of the color.
    public var red: Double

    /// The green component of the color.
    public var green: Double

    /// The blue component of the color.
    public var blue: Double

    /// The alpha (opacity) component of the color.
    public var alpha: Double

    /// Initializes a new `Color` instance with the specified red, green, blue, and alpha components.
    ///
    /// - Parameters:
    ///   - red: The red component of the color, specified as a `Double`.
    ///   - green: The green component of the color, specified as a `Double`.
    ///   - blue: The blue component of the color, specified as a `Double`.
    ///   - alpha: The alpha (opacity) component of the color, specified as a `Double`.
    public init(
        red: Double,
        green: Double,
        blue: Double,
        alpha: Double
    ) {
        self.red = red
        self.green = green
        self.blue = blue
        self.alpha = alpha
    }
}
