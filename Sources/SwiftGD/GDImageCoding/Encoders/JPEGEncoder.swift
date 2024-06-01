//
//  File.swift
//
//
//  Created by Tibor Bodecs on 31/05/2024.
//

import CLibGD
import Foundation.NSData

struct JPEGEncoder: GDImagePointerEncoder {

    let parameters: Int32

    /// Initializes a new instance of `Self` using given quality on exports.
    ///
    /// For practical purposes, the quality should be a value in the range `0...95`. For values less than or equal `0` or
    /// lower, the IJG JPEG quality value (which should yield a good general quality / size tradeoff for most situations) is used.
    ///
    /// - Parameter quality:
    ///     Compression quality to apply on exports. Defaults to -1.
    ///     See [Reference](https://libgd.github.io/manuals/2.2.5/files/gd_jpeg-c.html)
    init(quality: Int32 = -1) {
        parameters = quality
    }

    func encode(_ pointer: gdImagePtr) throws -> Data {
        var size: Int32 = 0
        guard let bytesPtr = gdImageJpegPtr(pointer, &size, parameters) else {
            throw GDImagePointerEncodingError.invalidValue
        }
        return Data(
            bytesNoCopy: bytesPtr,
            count: Int(size),
            deallocator: .custom({ ptr, _ in gdFree(ptr) })
        )
    }
}
