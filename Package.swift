// swift-tools-version: 5.7
import PackageDescription

let package = Package(
    name: "ServiceLocator",
    products: [
        .library(
            name: "ServiceLocator",
            targets: ["ServiceLocator"]
        ),
    ],
    dependencies: [
        .package(
            url: "https://github.com/mattgallagher/CwlPreconditionTesting.git",
            from: Version("2.0.0")
        )
    ],
    targets: [
        .target(
            name: "ServiceLocator",
            dependencies: []),
        .testTarget(
            name: "ServiceLocatorTests",
            dependencies: [
                "ServiceLocator",
                "CwlPreconditionTesting"
            ]
        ),
    ]
)
