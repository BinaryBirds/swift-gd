//
//  File.swift
//
//
//  Created by Tibor Bodecs on 31/05/2024.
//

import CLibGD
import Foundation.NSData

struct AVIFEncoder: GDImagePointerEncoder {

    func encode(_ pointer: gdImagePtr) throws -> Data {
        var size: Int32 = 0
        guard let bytesPtr = gdImageAvifPtr(pointer, &size) else {
            throw GDImagePointerEncodingError.invalidValue
        }
        return Data(bytes: bytesPtr, count: Int(size))
    }

}
