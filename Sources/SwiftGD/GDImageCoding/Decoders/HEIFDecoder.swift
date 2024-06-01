//
//  File.swift
//
//
//  Created by Tibor Bodecs on 01/06/2024.
//

import CLibGD
import Foundation.NSData

struct HEIFDecoder: GDImagePointerDecoder {

    func decode(from data: Data) throws -> gdImagePtr {
        let (pointer, size) = try data.memory()
        guard let imagePtr = gdImageCreateFromHeifPtr(size, pointer) else {
            throw GDImagePointerDecodingError.dataCorrupted(
                "Invalid HEIF data."
            )
        }
        return imagePtr
    }
}
