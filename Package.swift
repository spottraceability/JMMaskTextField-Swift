// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "JMMaskTextField",
    platforms: [.iOS(.v13), .macOS(.v10_15)],
    products: [
        .library(name: "JMMaskTextField", targets: ["JMMaskTextField"]),
    ],
    targets: [
        .target(name: "JMMaskTextField", path: "JMMaskTextField/Classes")
    ]
)
