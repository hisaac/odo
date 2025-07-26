// swift-tools-version: 6.0

import PackageDescription

let package = Package(
	name: "odo",
	dependencies: [
		.package(url: "https://github.com/apple/swift-argument-parser.git", from: "1.6.1"),
		.package(url: "https://github.com/jpsim/Yams.git", from: "5.1.3"),
	],
	targets: [
		.executableTarget(
			name: "odo",
			dependencies: [
				.product(name: "ArgumentParser", package: "swift-argument-parser"),
				.product(name: "Yams", package: "Yams"),
			]
		)
	]
)
