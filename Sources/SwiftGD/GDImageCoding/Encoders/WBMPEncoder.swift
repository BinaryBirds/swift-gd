//
//  File.swift
//
//
//  Created by Tibor Bodecs on 31/05/2024.
//

import CLibGD
import Foundation.NSData

struct WBMPEncoder: GDImagePointerEncoder {
    let parameters: Int32

    /// Initializes a new instance of `Self` using index as foreground color on exports.
    ///
    /// - Parameter index:
    ///     The index of the foreground color used on exports. Any other value will be considered as background and will not be written.
    ///     See [Reference](https://libgd.github.io/manuals/2.2.5/files/gd_wbmp-c.html)
    init(index: Int32) {
        parameters = index
    }

    func encode(_ pointer: gdImagePtr) throws -> Data {
        var size: Int32 = 0
        guard let bytesPtr = gdImageWBMPPtr(pointer, &size, parameters) else {
            throw GDImagePointerEncodingError.invalidValue
        }
        return Data(
            bytesNoCopy: bytesPtr,
            count: Int(size),
            deallocator: .custom({ ptr, _ in gdFree(ptr) })
        )
    }

}
