import Foundation

struct OperatingSystemProbe: SystemProbe {
	let friendlyName = "Operating System"
	let name = "operatingSystem"

	func probe() async throws -> [String: Any] {
		var result: [String: Any] = [:]

		let processInfo = ProcessInfo.processInfo
		result["operatingSystemVersion"] = [
			"majorVersion": processInfo.operatingSystemVersion.majorVersion,
			"minorVersion": processInfo.operatingSystemVersion.minorVersion,
			"patchVersion": processInfo.operatingSystemVersion.patchVersion,
		]

		return result
	}
}
