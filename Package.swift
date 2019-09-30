// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "Bohrium",
    platforms: [
        .iOS(.v9)
    ],
    products: [
      .library(name: "Bohrium", targets: ["Bohrium"])
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Bohrium",
            dependencies: [],
            path: "Sources"
        )
    ],
    swiftLanguageVersions: [ .v4, .v5 ]
)
