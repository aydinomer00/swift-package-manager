// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "swift-package-manager",
    platforms: [
        .macOS(.v10_15),
        .iOS(.v13)
    ],
    products: [
        .executable(
            name: "swift-package",
            targets: ["SwiftPM"]
        ),
        .library(
            name: "Commands",
            targets: ["Commands"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", from: "1.0.0"),
        .package(url: "https://github.com/apple/swift-tools-support-core", from: "0.2.7"),
        .package(url: "https://github.com/apple/swift-llbuild.git", from: "0.3.0"),
    ],
    targets: [
        .executableTarget(
            name: "SwiftPM",
            dependencies: ["Commands"]
        ),
        .target(
            name: "Commands",
            dependencies: [
                "SPMBuildCore",
                "PackageModel",
                "Workspace",
                .product(name: "SwiftToolsSupport-auto", package: "swift-tools-support-core"),
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                .product(name: "llbuildSwift", package: "swift-llbuild"),
            ]
        ),
        .target(
            name: "PackageModel",
            dependencies: [
                .product(name: "SwiftToolsSupport-auto", package: "swift-tools-support-core")
            ]
        ),
        .target(
            name: "SPMBuildCore",
            dependencies: [
                "PackageModel",
                .product(name: "SwiftToolsSupport-auto", package: "swift-tools-support-core")
            ]
        ),
        .target(
            name: "Workspace",
            dependencies: [
                "SPMBuildCore",
                "PackageModel"
            ]
        )
    ]
)
