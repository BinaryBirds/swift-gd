//
//  File.swift
//
//
//  Created by Tibor Bodecs on 31/05/2024.
//

import CLibGD

/// A structure representing an image, designed to be non-copyable.
///
/// The `Image` struct handles image data and provides various utilities to manage and manipulate images.
public struct Image: ~Copyable {

    /// An enumeration representing the color depth of the image.
    public enum ColorDepth {
        /// Basic color depth supporting up to 256 colors.
        /// Suitable for simple graphics with limited color requirements.
        case basic
        /// True color depth supporting millions of colors.
        /// Ideal for high-quality images with rich color details.
        case trueColor
    }

    /// An enumeration representing possible errors that can occur while working with images.
    public enum ImageError: Error {
        /// Indicates an error with the image pointer.
        case pointer
        /// Indicates a color-related error.
        case color
        /// Indicates a file-related error with an associated file name.
        /// - Parameter file: The name of the file that caused the error.
        case file(String)
    }

    /// An enumeration representing the possible directions for flipping an image.
    public enum FlipDirection {
        /// Flip the image horizontally.
        case horizontal
        /// Flip the image vertically.
        case vertical
        /// Flip the image both horizontally and vertically.
        case both
    }

    // MARK: -

    private(set) var pointer: gdImagePtr!

    init(pointer: gdImagePtr!) {
        self.pointer = pointer
    }

    deinit {
        freePointer()
    }

    // MARK: -

    public init(
        size: Size,
        type: ColorDepth = .trueColor
    ) {
        let w = Int32(size.width)
        let h = Int32(size.height)

        var pointer: gdImagePtr?
        switch type {
        case .basic:
            pointer = gdImageCreate(w, h)
        case .trueColor:
            pointer = gdImageCreateTrueColor(w, h)
        }
        self.pointer = pointer
    }
}

// MARK: - private

extension Image {

    private func freePointer() {
        gdImageDestroy(self.pointer)
    }

    private mutating func setPointer(_ value: gdImagePtr) {
        freePointer()
        pointer = value
    }

    private func allocateGDImageColorPointer(_ color: Color) -> Int32 {
        let c = GDColor(color: color)
        let colorPointer = gdImageColorAllocateAlpha(
            pointer,
            c.red,
            c.green,
            c.blue,
            c.alpha
        )
        return colorPointer
    }

    private func applyInterpolation(
        enabled: Bool,
        currentSize: Size,
        newSize: Size
    ) {
        guard enabled else {
            gdImageSetInterpolationMethod(pointer, GD_NEAREST_NEIGHBOUR)
            return
        }

        if currentSize > newSize {
            gdImageSetInterpolationMethod(pointer, GD_SINC)
        }
        else if currentSize < newSize {
            gdImageSetInterpolationMethod(pointer, GD_MITCHELL)
        }
        else {
            gdImageSetInterpolationMethod(pointer, GD_NEAREST_NEIGHBOUR)
        }
    }
}

// MARK: - internal

extension Image {

    public var size: Size {
        .init(
            width: Int(pointer.pointee.sx),
            height: Int(pointer.pointee.sy)
        )
    }

    public func clone() throws -> Self {
        guard let clone = gdImageClone(pointer) else {
            throw ImageError.pointer
        }
        return .init(pointer: clone)
    }

    public func flip(
        _ direction: FlipDirection
    ) {
        switch direction {
        case .horizontal:
            gdImageFlipHorizontal(pointer)
        case .vertical:
            gdImageFlipVertical(pointer)
        case .both:
            gdImageFlipBoth(pointer)
        }
    }

    public func setTransparency(
        enabled: Bool
    ) {
        gdImageSaveAlpha(pointer, enabled ? 1 : 0)
        gdImageAlphaBlending(pointer, enabled ? 0 : 1)
    }

    // MARK: - effects

    public func desaturate() {
        gdImageGrayScale(pointer)
    }

    public func invert() {
        gdImageNegate(pointer)
    }

    public func pixelate(blockSize: Int) {
        gdImagePixelate(pointer, Int32(blockSize), GD_PIXELATE_AVERAGE.rawValue)
    }

    public mutating func blur(radius: Int) throws {
        let r = Int32(radius)
        guard let newPointer = gdImageCopyGaussianBlurred(pointer, r, -1) else {
            throw ImageError.pointer
        }
        setPointer(newPointer)
    }

    public func brightness(_ value: Int) {
        gdImageBrightness(pointer, Int32(value))
    }

    // MARK: - color manipulation

    public func colorize(_ color: Color) {
        let c = GDColor(color: color)
        gdImageColor(pointer, c.red, c.green, c.blue, c.alpha)
    }

    public func reduceColors(
        max numberOfColors: Int,
        shouldDither: Bool = true
    ) throws {
        guard numberOfColors > 1 else {
            throw ImageError.color
        }
        let shouldDither: Int32 = shouldDither ? 1 : 0
        gdImageTrueColorToPalette(pointer, shouldDither, Int32(numberOfColors))
    }

    // MARK: - size manipulation

    public mutating func cropTo(
        rect: Rect
    ) throws {
        var rect = gdRect(
            x: Int32(rect.point.x),
            y: Int32(rect.point.y),
            width: Int32(rect.size.width),
            height: Int32(rect.size.height)
        )
        guard let newPointer = gdImageCrop(pointer, &rect) else {
            throw ImageError.pointer
        }
        setPointer(newPointer)
    }

    public mutating func rotateTo(
        angle: Angle
    ) throws {
        let a = Float(angle.degrees)
        guard let newPointer = gdImageRotateInterpolated(pointer, a, 0) else {
            throw ImageError.pointer
        }
        setPointer(newPointer)
    }

    public mutating func resizeTo(
        width: Int,
        height: Int,
        applySmoothing: Bool = true
    ) throws {
        applyInterpolation(
            enabled: applySmoothing,
            currentSize: size,
            newSize: Size(width: width, height: height)
        )

        let w = UInt32(width)
        let h = UInt32(height)
        guard let newPointer = gdImageScale(pointer, w, h) else {
            throw ImageError.pointer
        }
        setPointer(newPointer)
    }

    public mutating func scaleTo(
        width: Int,
        applySmoothing: Bool = true
    ) throws {
        let currentSize = size
        let scale = Double(width) / Double(currentSize.width)
        let newSize = Size(
            width: width,
            height: Int(Double(currentSize.height) * scale)
        )

        applyInterpolation(
            enabled: applySmoothing,
            currentSize: currentSize,
            newSize: newSize
        )

        let w = UInt32(newSize.width)
        let h = UInt32(newSize.height)
        guard let newPointer = gdImageScale(pointer, w, h) else {
            throw ImageError.pointer
        }
        setPointer(newPointer)
    }

    public mutating func scaleTo(
        height: Int,
        applySmoothing: Bool = true
    ) throws {
        let currentSize = size
        let scale = Double(height) / Double(currentSize.height)
        let newSize = Size(
            width: Int(Double(currentSize.width) * scale),
            height: height
        )

        applyInterpolation(
            enabled: applySmoothing,
            currentSize: currentSize,
            newSize: newSize
        )

        let w = UInt32(newSize.width)
        let h = UInt32(height)
        guard let newPointer = gdImageScale(pointer, w, h) else {
            throw ImageError.pointer
        }
        setPointer(newPointer)
    }

    // MARK: - pixel color

    public func color(
        at point: Point
    ) -> Color {
        let x = Int32(point.x)
        let y = Int32(point.y)
        let c = gdImageGetTrueColorPixel(pointer, x, y)
        let a = Double((c >> 24) & 0xFF)
        let r = Double((c >> 16) & 0xFF)
        let g = Double((c >> 8) & 0xFF)
        let b = Double(c & 0xFF)

        return .init(
            red: r / 255,
            green: g / 255,
            blue: b / 255,
            alpha: 1 - (a / 127)
        )
    }

    public func fill(
        point: Point,
        color: Color
    ) {
        let colorPointer = allocateGDImageColorPointer(color)
        defer {
            gdImageColorDeallocate(pointer, colorPointer)
        }
        gdImageSetPixel(
            pointer,
            Int32(point.x),
            Int32(point.y),
            colorPointer
        )
    }

    // MARK: - draw methods

    public func floodFill(
        at point: Point,
        color: Color
    ) {
        let colorPointer = allocateGDImageColorPointer(color)
        defer {
            gdImageColorDeallocate(pointer, colorPointer)
        }
        gdImageFill(
            pointer,
            Int32(point.x),
            Int32(point.y),
            colorPointer
        )
    }

    public func draw(
        line: Line,
        color: Color
    ) {
        let colorPointer = allocateGDImageColorPointer(color)
        defer {
            gdImageColorDeallocate(pointer, colorPointer)
        }
        gdImageLine(
            pointer,
            Int32(line.from.x),
            Int32(line.from.y),
            Int32(line.to.x),
            Int32(line.to.y),
            colorPointer
        )
    }

    public func draw(
        ellipse: Ellipse,
        color: Color
    ) {
        let colorPointer = allocateGDImageColorPointer(color)
        defer {
            gdImageColorDeallocate(pointer, colorPointer)
        }

        gdImageEllipse(
            pointer,
            Int32(ellipse.center.x),
            Int32(ellipse.center.y),
            Int32(ellipse.size.width),
            Int32(ellipse.size.height),
            colorPointer
        )
    }

    public func fill(
        ellipse: Ellipse,
        color: Color
    ) {
        let colorPointer = allocateGDImageColorPointer(color)
        defer {
            gdImageColorDeallocate(pointer, colorPointer)
        }

        gdImageFilledEllipse(
            pointer,
            Int32(ellipse.center.x),
            Int32(ellipse.center.y),
            Int32(ellipse.size.width),
            Int32(ellipse.size.height),
            colorPointer
        )
    }

    public func draw(
        rect: Rect,
        color: Color
    ) {
        let colorPointer = allocateGDImageColorPointer(color)
        defer {
            gdImageColorDeallocate(pointer, colorPointer)
        }

        let topLeft = rect.point
        let bottomRight = Point(
            x: topLeft.x + rect.size.width,
            y: topLeft.y + rect.size.height
        )

        gdImageRectangle(
            pointer,
            Int32(topLeft.x),
            Int32(topLeft.y),
            Int32(bottomRight.x),
            Int32(bottomRight.y),
            colorPointer
        )
    }

    public func fill(
        rect: Rect,
        color: Color
    ) {
        let colorPointer = allocateGDImageColorPointer(color)
        defer {
            gdImageColorDeallocate(pointer, colorPointer)
        }

        let topLeft = rect.point
        let bottomRight = Point(
            x: topLeft.x + rect.size.width,
            y: topLeft.y + rect.size.height
        )

        gdImageFilledRectangle(
            pointer,
            Int32(topLeft.x),
            Int32(topLeft.y),
            Int32(bottomRight.x),
            Int32(bottomRight.y),
            colorPointer
        )
    }

    public func drawImage(
        _ image: borrowing Image,
        at topLeft: Point = .zero
    ) {
        let width = Int32(size.width - topLeft.x)
        let height = Int32(size.height - topLeft.y)
        let x = Int32(topLeft.x)
        let y = Int32(topLeft.y)

        gdImageCopy(pointer, image.pointer, x, y, 0, 0, width, height)
    }

    @discardableResult
    public func draw(
        text: String,
        at point: Point,
        fontList: [String],
        color: Color,
        size: Double,
        angle: Angle = .zero
    ) -> Rect? {
        guard !text.isEmpty, !fontList.isEmpty else {
            return nil
        }

        let colorPointer = allocateGDImageColorPointer(color)
        defer {
            gdImageColorDeallocate(pointer, colorPointer)
        }

        var textCChar = Array(text.utf8CString)
        var joinedFonts = Array(fontList.joined(separator: ";").utf8CString)

        // lower left, lower right, upper right, and upper left corner.
        var boundingBox: [Int32] = .init(repeating: .zero, count: 8)
        gdImageStringFT(
            pointer,
            &boundingBox,
            colorPointer,
            &joinedFonts,
            size,
            -angle.radians,
            Int32(point.x),
            Int32(point.y),
            &textCChar
        )

        let topLeft = Point(x: Int(boundingBox[6]), y: Int(boundingBox[7]))
        let bottomRight = Point(x: Int(boundingBox[2]), y: Int(boundingBox[3]))

        return .init(
            point: topLeft,
            size: .init(
                width: bottomRight.x - topLeft.x,
                height: bottomRight.y - topLeft.y
            )
        )
    }
}
