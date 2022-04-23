// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "DiscordBotExample",
  platforms: [.macOS(.v12)],
  products: [
    // Products define the executables and libraries a package produces, and make them visible to other packages.
    .executable(
      name: "DiscordBotExample",
      targets: ["DiscordBotExample"]),
  ],
  dependencies: [
    // Dependencies declare other packages that this package depends on.
    .package(name: "Discord", path: "../"),
    .package(url: "https://github.com/apple/swift-argument-parser", from: "1.1.2")
  ],
  targets: [
    // Targets are the basic building blocks of a package. A target can define a module or a test suite.
    // Targets can depend on other targets in this package, and on products in packages this package depends on.
    .executableTarget(
      name: "DiscordBotExample",
      dependencies: [
        "Discord",
        .product(name: "ArgumentParser", package: "swift-argument-parser")
      ])
  ]
)
