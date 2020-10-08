// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "AsteroidWatchLoginAPI",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(
            name: "AsteroidWatchLoginAPI",
            targets: ["AsteroidWatchLoginAPI"]),
    ],
    dependencies: [
        .package(url: "https://github.com/screensailor/Hope.git", .branch("trunk"))
    ],
    targets: [
        .target(
            name: "AsteroidWatchLoginAPI",
            dependencies: [
                .byName(name: "Hope")
            ]
        ),
        .testTarget(
            name: "AsteroidWatchLoginAPITests",
            dependencies: ["AsteroidWatchLoginAPI"]),
    ]
)
