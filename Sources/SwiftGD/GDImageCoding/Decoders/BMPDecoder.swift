//
//  File.swift
//
//
//  Created by Tibor Bodecs on 31/05/2024.
//

import CLibGD
import Foundation.NSData

struct BMPDecoder: GDImagePointerDecoder {

    func decode(from data: Data) throws -> gdImagePtr {
        let (pointer, size) = try data.memory()
        guard let imagePtr = gdImageCreateFromBmpPtr(size, pointer) else {
            throw GDImagePointerDecodingError.dataCorrupted(
                "Invalid BMP data."
            )
        }
        return imagePtr
    }
}
