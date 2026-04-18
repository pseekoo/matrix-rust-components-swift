// swift-tools-version:5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.
import PackageDescription

// Local-fork version. The binary target points at the xcframework built
// from the sibling matrix-rust-sdk checkout via:
//   cd ../matrix-rust-sdk
//   cargo xtask swift build-framework --release \
//       --target aarch64-apple-ios \
//       --target aarch64-apple-ios-sim \
//       --target x86_64-apple-ios
//
// To switch back to the upstream release, restore the `url + checksum`
// form from the 26.04.01 tag.
let package = Package(
    name: "MatrixRustSDK",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(name: "MatrixRustSDK", type: .dynamic, targets: ["MatrixRustSDK"]),
    ],
    targets: [
        .binaryTarget(
            name: "MatrixSDKFFI",
            path: "../matrix-rust-sdk/bindings/apple/generated/MatrixSDKFFI.xcframework"
        ),
        .target(name: "MatrixRustSDK", dependencies: [.target(name: "MatrixSDKFFI")])
    ]
)
