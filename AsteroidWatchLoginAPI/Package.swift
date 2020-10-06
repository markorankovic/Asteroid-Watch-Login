// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "AsteroidWatchLoginAPI",
    products: [
        .library(
            name: "AsteroidWatchLoginAPI",
            targets: ["AsteroidWatchLoginAPI"]),
    ],
    targets: [
        .target(
            name: "AsteroidWatchLoginAPI",
            dependencies: []),
        .testTarget(
            name: "AsteroidWatchLoginAPITests",
            dependencies: ["AsteroidWatchLoginAPI"]),
    ]
)

