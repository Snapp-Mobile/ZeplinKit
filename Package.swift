// swift-tools-version: 5.6

import PackageDescription

let package = Package(
    name: "ZeplinKit",
    platforms: [
        .iOS(.v13),
        .macOS(.v11),
    ],
    products: [
        .library(
            name: "ZeplinKit",
            targets: ["ZeplinKit"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/Snapp-Mobile/Fetcher", from: "0.0.2"),
        .package(url: "https://github.com/marmelroy/Zip", from: "2.0.0"),
    ],
    targets: [
        .target(
            name: "ZeplinKit",
            dependencies: ["Fetcher", "Zip"],
            path: "Sources",
            resources: [
                .process("Mocks")
            ]
        ),
        .testTarget(
            name: "ZeplinKitTests",
            dependencies: ["ZeplinKit", "Fetcher"],
            path: "Tests",
        ),
    ]
)
