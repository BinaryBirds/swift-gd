//
//  File.swift
//
//
//  Created by Tibor Bodecs on 31/05/2024.
//

import CLibGD
import Foundation.NSData

protocol GDImagePointerEncoder {

    func encode(_ pointer: gdImagePtr) throws -> Data
}
