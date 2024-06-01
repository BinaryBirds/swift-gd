//
//  File.swift
//
//
//  Created by Tibor Bodecs on 31/05/2024.
//

import CLibGD
import Foundation.NSData

struct GIFDecoder: GDImagePointerDecoder {

    func decode(from data: Data) throws -> gdImagePtr {
        let (pointer, size) = try data.memory()
        guard let imagePtr = gdImageCreateFromGifPtr(size, pointer) else {
            throw GDImagePointerDecodingError.dataCorrupted(
                "Invalid GIF data."
            )
        }
        return imagePtr
    }
}
