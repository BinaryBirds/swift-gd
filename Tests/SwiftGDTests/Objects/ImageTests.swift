//
//  File.swift
//
//
//  Created by Tibor Bodecs on 31/05/2024.
//

import SwiftGD
import XCTest

final class ImageTests: XCTestCase {

    func testInitialization() throws {
        var image = Image(
            size: .init(
                width: 640,
                height: 480
            )
        )

        image.setTransparency(enabled: true)

        image.fill(
            ellipse: .init(
                center: .init(x: 64, y: 64),
                size: .init(width: 64, height: 64)
            ),
            color: .magenta
        )

        image.draw(
            ellipse: .init(
                center: .init(x: 64, y: 64),
                size: .init(width: 64, height: 64)
            ),
            color: .yellow
        )

        image.draw(
            line: .init(
                from: .init(x: 64, y: 64),
                to: .init(x: 128, y: 128)
            ),
            color: .white
        )

        image.fill(
            rect: .init(
                point: .init(x: 128, y: 128),
                size: .init(width: 64, height: 32)
            ),
            color: .cyan
        )

        image.draw(
            rect: .init(
                point: .init(x: 128, y: 128),
                size: .init(width: 64, height: 32)
            ),
            color: .red
        )

        image.floodFill(
            at: .init(x: 129, y: 129),
            color: .blue
        )

        image.fill(
            point: .init(x: 200, y: 200),
            color: .white
        )

        let c = image.color(at: .init(x: 200, y: 200))

        XCTAssertTrue(c == .white)

        try image.blur(radius: 10)
        image.pixelate(blockSize: 10)
        image.desaturate()

        image.flip(.horizontal)
        try image.rotateTo(angle: .init(degrees: 30))

        image.invert()
        image.draw(
            text: "lorem ipsum dolor sit amet",
            at: .init(x: 100, y: 100),
            fontList: ["SFCompact"],
            color: .red,
            size: 50
        )
        image.brightness(-100)

        let encoder = ImageEncoder(format: .png)
        let data = try encoder.encode(image)

        let url = URL(fileURLWithPath: "/Users/tib/test.png")
        try data.write(to: url)
    }
}
