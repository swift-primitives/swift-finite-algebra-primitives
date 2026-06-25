// swift-tools-version: 6.3.1

import PackageDescription

let package = Package(
    name: "swift-finite-algebra-primitives",
    platforms: [
        .macOS(.v26),
        .iOS(.v26),
        .tvOS(.v26),
        .watchOS(.v26),
        .visionOS(.v26)
    ],
    products: [
        // MARK: - Integration surface (finite ⊗ algebra)
        .library(
            name: "Finite Algebra Primitives",
            targets: ["Finite Algebra Primitives"]
        ),

        // MARK: - Test Support
        .library(
            name: "Finite Algebra Primitives Test Support",
            targets: ["Finite Algebra Primitives Test Support"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/swift-primitives/swift-finite-primitives.git", branch: "main"),
        .package(url: "https://github.com/swift-primitives/swift-algebra-primitives.git", branch: "main"),
        .package(url: "https://github.com/swift-primitives/swift-parity-primitives.git", branch: "main"),
        .package(url: "https://github.com/swift-primitives/swift-polarity-primitives.git", branch: "main"),
    ],
    targets: [
        // MARK: - Integration surface
        .target(
            name: "Finite Algebra Primitives",
            dependencies: [
                .product(name: "Finite Primitives", package: "swift-finite-primitives"),
                .product(name: "Algebra Primitives", package: "swift-algebra-primitives"),
                .product(name: "Algebra Group Primitives", package: "swift-algebra-primitives"),
                .product(name: "Parity Primitives", package: "swift-parity-primitives"),
                .product(name: "Polarity Primitives", package: "swift-polarity-primitives"),
            ]
        ),

        // MARK: - Test Support
        .target(
            name: "Finite Algebra Primitives Test Support",
            dependencies: [
                "Finite Algebra Primitives",
                .product(name: "Algebra Primitives Test Support", package: "swift-algebra-primitives"),
            ],
            path: "Tests/Support"
        ),

        // MARK: - Tests
        .testTarget(
            name: "Finite Algebra Primitives Tests",
            dependencies: [
                "Finite Algebra Primitives",
                "Finite Algebra Primitives Test Support",
            ]
        ),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets where ![.system, .binary, .plugin, .macro].contains(target.type) {
    let ecosystem: [SwiftSetting] = [
        .strictMemorySafety(),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
        .enableExperimentalFeature("LifetimeDependence"),
        .enableExperimentalFeature("Lifetimes"),
        .enableExperimentalFeature("SuppressedAssociatedTypes"),
        .enableUpcomingFeature("InferIsolatedConformances"),
        .enableUpcomingFeature("LifetimeDependence"),
    ]

    let package: [SwiftSetting] = []

    target.swiftSettings = (target.swiftSettings ?? []) + ecosystem + package
}
