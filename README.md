# SwiftGD

A Swift wrapper around the [libgd](https://github.com/libgd/libgd) graphics library.

## Getting started

⚠️ This repository is a work in progress, things can break until it reaches v1.0.0. 

Use at your own risk.

### Adding the dependency

To add a dependency on the package, declare it in your `Package.swift`:

```swift
.package(url: "https://github.com/binarybirds/swift-gd", .upToNextMinor(from: "0.1.0")),
```

and to your application target, add `SwiftGD` to your dependencies:

```swift
.product(name: "SwiftGD", package: "swift-gd")
```

Example `Package.swift` file with `FeatherDatabase` as a dependency:

```swift
// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "my-application",
    dependencies: [
        .package(url: "https://github.com/binarybirds/swift-gd", .upToNextMinor(from: "0.1.0")),
    ],
    targets: [
        .target(name: "MyApplication", dependencies: [
            .product(name: "SwiftGD", package: "swift-gd")
        ]),
        .testTarget(name: "MyApplicationTests", dependencies: [
            .target(name: "MyApplication"),
        ]),
    ]
)
```

