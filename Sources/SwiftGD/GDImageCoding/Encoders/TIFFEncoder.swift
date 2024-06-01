//
//  File.swift
//
//
//  Created by Tibor Bodecs on 31/05/2024.
//

import CLibGD
import Foundation.NSData

struct TIFFEncoder: GDImagePointerEncoder {

    func encode(_ pointer: gdImagePtr) throws -> Data {
        var size: Int32 = 0
        guard let bytesPtr = gdImageTiffPtr(pointer, &size) else {
            throw GDImagePointerEncodingError.invalidValue
        }
        return Data(bytes: bytesPtr, count: Int(size))
    }

}
