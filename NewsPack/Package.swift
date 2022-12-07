// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NewsPack",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "NewsPack",
            targets: ["NewsPack"]),
    ],
    dependencies: [.package(url: "https://github.com/SnapKit/SnapKit.git", .upToNextMajor(from: "5.0.1"))
    ],
    targets: [
        .target(
            name: "NewsPack",
            dependencies: ["SnapKit"]),
        .testTarget(
            name: "NewsPackTests",
            dependencies: ["NewsPack"]),
    ]
)
