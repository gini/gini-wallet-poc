// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Core",
    platforms: [.iOS(.v14)],
    products: [
        .library(name: "Core", targets: ["Core"])
    ],
    dependencies: [
        .package(url: "https://github.com/halcyonmobile/RestBird.git", from: "0.5.0"),
        .package(url: "https://github.com/Liftric/DIKit.git", from: "1.6.0")
    ],
    targets: [
        .target(name: "Core", dependencies: ["RestBird", "DIKit"]),
        .testTarget(name: "CoreTests", dependencies: ["Core"])
    ]
)
