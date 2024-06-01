//
//  File.swift
//
//
//  Created by Tibor Bodecs on 31/05/2024.
//

import CLibGD
import Foundation.NSData

struct BMPEncoder: GDImagePointerEncoder {

    private let parameters: Int32

    /// Initializes a new instance of `Self` using given RLE compression option on exports.
    ///
    /// - Parameter compression:
    ///     Indicates whether to apply RLE compression on export or not. Defaults to `false`.
    ///     See [Reference](https://libgd.github.io/manuals/2.2.5/files/gd_bmp-c.html)
    init(compression: Bool = false) {
        parameters = compression ? 1 : 0
    }

    func encode(_ pointer: gdImagePtr) throws -> Data {
        var size: Int32 = 0
        guard let bytesPtr = gdImageBmpPtr(pointer, &size, parameters) else {
            throw GDImagePointerEncodingError.invalidValue
        }
        return Data(
            bytesNoCopy: bytesPtr,
            count: Int(size),
            deallocator: .custom({ ptr, _ in gdFree(ptr) })
        )
    }
}
