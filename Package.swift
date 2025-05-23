// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FoxGen",
    platforms: [.macOS(.v11)],
    products: [
        .executable(name: "foxgen", targets: ["FoxGen"])
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", exact: "1.5.0"),
        .package(url: "https://github.com/jpsim/Yams", exact: "5.3.1")
    ],
    targets: [
        .executableTarget(
            name: "FoxGen",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                .product(name: "Yams", package: "Yams")
            ],
            path: "Sources"
        )
    ]
)
