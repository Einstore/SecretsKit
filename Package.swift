// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "SecretsKit",
    products: [
        .executable(name: "random-generator", targets: ["RandomGenerator"]),
        .library(name: "SecretsKit", targets: ["SecretsKit"])
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/vapor.git", from: "4.0.0-alpha.1.5"),
        .package(url: "https://github.com/vapor/crypto-kit.git", from: "4.0.0-alpha.1")
    ],
    targets: [
        .target(
            name: "SecretsKit",
            dependencies: [
                "CryptoKit",
                "Vapor"
            ]
        ),
        .target(
            name: "RandomGenerator",
            dependencies: [
                "CryptoKit"
            ]
        ),
        .testTarget(
            name: "SecretsKitTests",
            dependencies: ["SecretsKit"]
        )
    ]
)


