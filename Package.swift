// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FoxGen",
    platforms: [.macOS(.v13)],
    products: [
        .executable(name: "foxgen", targets: ["FoxGen"])
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", exact: "1.2.3"),
        .package(url: "https://github.com/jpsim/Yams", exact: "5.0.6")
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
