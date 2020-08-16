// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "MySwiftBlogWebsite",
    products: [
        .executable(name: "MySwiftBlogWebsite", targets: ["MySwiftBlogWebsite"])
    ],
    dependencies: [
        .package(url: "https://github.com/johnsundell/publish.git", from: "0.3.0")
    ],
    targets: [
        .target(
            name: "MySwiftBlogWebsite",
            dependencies: ["Publish"]
        )
    ]
)