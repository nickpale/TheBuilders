// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "TheBuilders",
    products: [
        .executable(name: "Runner", targets: ["Runner"]),
        .executable(name: "Server", targets: ["Server"])
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/vapor/vapor.git", .upToNextMinor(from: "3.0.0")),
        .package(url: "https://github.com/apple/swift-nio.git", from: "1.0.0")
    ],
    targets: [
        .target(name: "Runner", dependencies: ["Kit", "Games", "NIO"]),
        .target(name: "Kit", dependencies: ["NIO"]),
        .target(name: "Games", dependencies: ["Kit", "NIO"]),
        .target(name: "Server", dependencies: ["Vapor", "Games"])
    ]
)
