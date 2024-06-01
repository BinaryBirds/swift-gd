//
//  File.swift
//
//
//  Created by Tibor Bodecs on 31/05/2024.
//

import Foundation.NSData

/// A structure for encoding images into various formats.
///
/// The `ImageEncoder` struct provides functionality to encode images into different formats
/// such as AVIF, BMP, GIF, HEIF, JPEG, PNG, TIFF, WBMP, and WEBP.
public struct ImageEncoder {

    /// An enumeration representing possible encoding errors.
    public enum EncodingError: Error {
        /// An error indicating an invalid value was provided.
        case invalidValue(String)
    }

    /// An enumeration representing the various image formats that can be used for encoding.
    public enum Format {
        /// AVIF format.
        /// See: https://en.wikipedia.org/wiki/AVIF
        case avif
        /// BMP format with optional compression.
        /// See: https://en.wikipedia.org/wiki/BMP_file_format
        case bmp(compression: Bool)
        /// GIF format.
        /// See: https://en.wikipedia.org/wiki/gif
        case gif
        /// HEIF format.
        /// See: https://en.wikipedia.org/wiki/High_Efficiency_Image_File_Format
        case heif
        /// JPEG format with a specified quality.
        /// See: https://en.wikipedia.org/wiki/jpeg
        case jpeg(quality: Int32)
        /// PNG format.
        /// See: https://en.wikipedia.org/wiki/Portable_Network_Graphics
        case png
        /// TIFF format.
        /// See: https://en.wikipedia.org/wiki/tiff
        case tiff
        /// WBMP format with a specified index.
        /// See: https://en.wikipedia.org/wiki/wbmp
        case wbmp(index: Int32)
        /// WEBP format.
        /// See: https://en.wikipedia.org/wiki/webp
        case webp

        /// Provides the appropriate encoder for the selected format.
        var encoder: GDImagePointerEncoder {
            switch self {
            case .avif:
                return AVIFEncoder()
            case .bmp(let compression):
                return BMPEncoder(compression: compression)
            case .heif:
                return HEIFEncoder()
            case .gif:
                return GIFEncoder()
            case .jpeg(let quality):
                return JPEGEncoder(quality: quality)
            case .png:
                return PNGEncoder()
            case .tiff:
                return TIFFEncoder()
            case .wbmp(let index):
                return WBMPEncoder(index: index)
            case .webp:
                return WEBPEncoder()
            }
        }
    }

    /// The format to use for encoding images.
    public let format: Format

    /// Initializes a new image encoder with the specified format.
    ///
    /// - Parameter format: The format to use for encoding images.
    public init(format: Format) {
        self.format = format
    }

    /// Encodes the given image into the specified format.
    ///
    /// - Parameter image: The image to encode.
    /// - Returns: The encoded image data.
    /// - Throws: `EncodingError.invalidValue` if the encoding process fails.
    public func encode(_ image: borrowing Image) throws -> Data {
        do {
            return try format.encoder.encode(image.pointer)
        }
        catch {
            throw EncodingError.invalidValue("\(error)")
        }
    }
}
