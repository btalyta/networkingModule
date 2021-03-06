// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NetworkingModule",
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "NetworkingModule",
            targets: ["NetworkingModule"]),
    ],
    dependencies: [
        .package(
            url: "https://github.com/AliSoftware/OHHTTPStubs",
            from: "9.0.0"
        )
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "NetworkingModule",
            dependencies: []),
        .testTarget(
            name: "NetworkingModuleTests",
            dependencies: [
                "NetworkingModule",
                "OHHTTPStubs",
                .product(name: "OHHTTPStubsSwift", package: "OHHTTPStubs")
            ]
        ),
    ]
)
