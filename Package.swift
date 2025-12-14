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

// Enable MainActor isolation and Approachable Concurrency features
for target in package.targets {
	var settings = target.swiftSettings ?? []
	settings.append(contentsOf: [
		.defaultIsolation(MainActor.self),
		.enableUpcomingFeature("NonisolatedNonsendingByDefault"),
		.enableUpcomingFeature("InferIsolatedConformances"),
	])
	target.swiftSettings = settings
}
