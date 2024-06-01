//
//  File.swift
//
//
//  Created by Tibor Bodecs on 31/05/2024.
//

import Foundation.NSData

/// A structure for decoding images from various formats.
///
/// The `ImageDecoder` struct provides functionality to decode images from different formats
/// such as AVIF, BMP, GIF, HEIF, JPEG, PNG, TGA, TIFF, WBMP, and WEBP.
public struct ImageDecoder {

    /// An enumeration representing possible decoding errors.
    public enum DecodingError: Error {
        /// An error indicating that the data is corrupted.
        case dataCorrupted(String)
    }

    /// An enumeration representing the various image formats that can be used for decoding.
    public enum Format {
        /// AVIF format.
        /// See: https://en.wikipedia.org/wiki/AVIF
        case avif
        /// BMP format.
        /// See: https://en.wikipedia.org/wiki/BMP_file_format
        case bmp
        /// GIF format.
        /// See: https://en.wikipedia.org/wiki/gif
        case gif
        /// HEIF format.
        /// See: https://en.wikipedia.org/wiki/High_Efficiency_Image_File_Format
        case heif
        /// JPEG format.
        /// See: https://en.wikipedia.org/wiki/jpeg
        case jpeg
        /// PNG format.
        /// See: https://en.wikipedia.org/wiki/Portable_Network_Graphics
        case png
        /// TGA format.
        /// See: https://en.wikipedia.org/wiki/Truevision_TGA
        case tga
        /// TIFF format.
        /// See: https://en.wikipedia.org/wiki/tiff
        case tiff
        /// WBMP format.
        /// See: https://en.wikipedia.org/wiki/wbmp
        case wbmp
        /// WEBP format.
        /// See: https://en.wikipedia.org/wiki/webp
        case webp

        /// Provides the appropriate decoder for the selected format.
        var decoder: GDImagePointerDecoder {
            switch self {
            case .avif:
                return AVIFDecoder()
            case .bmp:
                return BMPDecoder()
            case .gif:
                return GIFDecoder()
            case .heif:
                return HEIFDecoder()
            case .jpeg:
                return JPEGDecoder()
            case .png:
                return PNGDecoder()
            case .tga:
                return TGADecoder()
            case .tiff:
                return TIFFDecoder()
            case .wbmp:
                return WBMPDecoder()
            case .webp:
                return WEBPDecoder()
            }
        }
    }

    /// The format to use for decoding images.
    public let format: Format

    /// Initializes a new image decoder with the specified format.
    ///
    /// - Parameter format: The format to use for decoding images.
    public init(format: Format) {
        self.format = format
    }

    /// Decodes image data into an image.
    ///
    /// - Parameter data: The data to decode.
    /// - Returns: The decoded image.
    /// - Throws: `DecodingError.dataCorrupted` if the decoding process fails.
    public func decode(from data: Data) throws -> Image {
        do {
            let pointer = try format.decoder.decode(from: data)
            return .init(pointer: pointer)
        }
        catch {
            throw DecodingError.dataCorrupted("\(error)")
        }
    }
}
