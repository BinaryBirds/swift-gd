//
//  File.swift
//
//
//  Created by Tibor Bodecs on 31/05/2024.
//

/// A structure representing a color in the GD (Graphics Device) color space.
///
/// The `GDColor` struct provides a representation of a color using the RGBA (Red, Green, Blue, Alpha) color model.
struct GDColor {

    /// The red component of the color.
    let red: Int32

    /// The green component of the color.
    let green: Int32

    /// The blue component of the color.
    let blue: Int32

    /// The alpha (opacity) component of the color.
    let alpha: Int32

    /// Initializes a new `GDColor` instance with the specified `Color` instance.
    ///
    /// This initializer converts the floating-point color components of a `Color` instance to 32-bit integer values
    /// for use with graphics devices. The alpha component is converted to a range suitable for the GD library, where
    /// `0` is fully opaque and `127` is fully transparent.
    ///
    /// - Parameter color: The `Color` instance to convert.
    init(color: Color) {
        self.red = Int32(color.red * 255.0)
        self.green = Int32(color.green * 255.0)
        self.blue = Int32(color.blue * 255.0)
        self.alpha = 127 - Int32(color.alpha * 127.0)
    }
}
