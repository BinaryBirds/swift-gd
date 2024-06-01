//
//  File.swift
//
//
//  Created by Tibor Bodecs on 01/06/2024.
//

import CLibGD
import Foundation.NSData

struct HEIFEncoder: GDImagePointerEncoder {

    func encode(_ pointer: gdImagePtr) throws -> Data {
        var size: Int32 = 0
        guard let bytesPtr = gdImageHeifPtr(pointer, &size) else {
            throw GDImagePointerEncodingError.invalidValue
        }
        return Data(bytes: bytesPtr, count: Int(size))
    }
}
