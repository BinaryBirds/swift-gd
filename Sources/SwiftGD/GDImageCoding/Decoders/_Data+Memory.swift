//
//  File.swift
//
//
//  Created by Tibor Bodecs on 31/05/2024.
//

import Foundation.NSData

extension Data {

    func memory() throws -> (pointer: UnsafeMutableRawPointer, size: Int32) {
        guard count < Int32.max else {
            throw GDImagePointerDecodingError.dataCorrupted(
                "Given image data exceeds maximum allowed bytes (must be int32 convertible)"
            )
        }
        return (
            pointer: try withUnsafeBytes {
                guard let baseAddress = $0.baseAddress else {
                    throw GDImagePointerDecodingError.dataCorrupted(
                        "Given image data doesn't have a valid base address in memory."
                    )
                }
                return UnsafeMutableRawPointer(mutating: baseAddress)
            },
            size: Int32(count)
        )
    }
}
