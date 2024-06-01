//
//  File.swift
//
//
//  Created by Tibor Bodecs on 31/05/2024.
//

import CLibGD

#if canImport(Glibc)
import Glibc
#endif
#if canImport(Darwin)
import Darwin
#endif

extension Image {

    static func loadJPEG(at path: String) throws -> Self {
        let fileHandle = fopen(path, "rb")
        guard fileHandle != nil else {
            throw ImageError.file(path)
        }
        defer { fclose(fileHandle) }
        guard let pointer = gdImageCreateFromJpeg(fileHandle) else {
            throw ImageError.pointer
        }
        return .init(pointer: pointer)
    }

    static func loadPNG(at path: String) throws -> Self {
        let fileHandle = fopen(path, "rb")
        guard fileHandle != nil else {
            throw ImageError.file(path)
        }
        defer { fclose(fileHandle) }
        guard let pointer = gdImageCreateFromPng(fileHandle) else {
            throw ImageError.pointer
        }
        return .init(pointer: pointer)
    }

    func saveJPEG(
        to path: String,
        quality: Int = 100
    ) throws {
        let fileHandle = fopen(path, "wb")
        guard fileHandle != nil else {
            throw ImageError.file(path)
        }
        defer { fclose(fileHandle) }

        gdImageJpeg(pointer, fileHandle, Int32(quality))
    }

    func savePNG(
        to path: String
    ) throws {
        let fileHandle = fopen(path, "wb")
        guard fileHandle != nil else {
            throw ImageError.file(path)
        }
        defer { fclose(fileHandle) }

        gdImageSaveAlpha(pointer, 1)
        gdImagePng(pointer, fileHandle)
    }
}
