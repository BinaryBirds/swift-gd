//
//  File.swift
//
//
//  Created by Tibor Bodecs on 31/05/2024.
//

import CLibGD
import Foundation.NSData

struct PNGDecoder: GDImagePointerDecoder {

    func decode(from data: Data) throws -> gdImagePtr {
        let (pointer, size) = try data.memory()
        guard let imagePtr = gdImageCreateFromPngPtr(size, pointer) else {
            throw GDImagePointerDecodingError.dataCorrupted(
                "Invalid PNG data."
            )
        }
        return imagePtr
    }
}
