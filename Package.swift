// swift-tools-version: 6.2

import PackageDescription

let package = Package(
	name: "odo",
	dependencies: [
		.package(url: "https://github.com/apple/swift-argument-parser.git", from: "1.6.1"),
	],
	targets: [
		.executableTarget(
			name: "odo",
			dependencies: [
				.product(name: "ArgumentParser", package: "swift-argument-parser"),
			]
		),
	]
)
