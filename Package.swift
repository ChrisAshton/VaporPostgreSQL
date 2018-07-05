// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "VaporPostgreSQL", // changed
    dependencies: [
        // 💧 A server-side Swift web framework.
        .package(url: "https://github.com/vapor/vapor.git", from: "3.0.5"),

        // Leaf package
        .package(url: "https://github.com/vapor/leaf.git", from: "3.0.0-rc.2"),

        // PostgreSQL package
        .package(url: "https://github.com/vapor/fluent-postgresql.git", from: "1.0.0-rc")
    ],
    targets: [
        .target(name: "App", dependencies: ["FluentPostgreSQL", "Vapor", "Leaf"]),
        .target(name: "Run", dependencies: ["App"]),
        .testTarget(name: "AppTests", dependencies: ["App"])
    ]
)
