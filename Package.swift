// swift-tools-version: 6.2

import PackageDescription

let package = Package(
	name: "odo",
	platforms: [
		.macOS(.v26)
	],
	dependencies: [
		.package(url: "https://github.com/apple/swift-argument-parser.git", from: "1.6.2")
	],
	targets: [
		.executableTarget(
			name: "odo",
			dependencies: [
				.product(name: "ArgumentParser", package: "swift-argument-parser")
			]
		)
	]
)
