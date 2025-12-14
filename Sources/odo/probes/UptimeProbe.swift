import Foundation

struct UptimeProbe: SystemProbe {
	let friendlyName = "System Uptime"
	let name = "uptime"

	@MainActor
	func probe() async throws -> [String: Any] {
		var result: [String: Any] = [:]

		let uptimeInterval = ProcessInfo.processInfo.systemUptime
		result["uptimeSeconds"] = Int(uptimeInterval)
		result["uptimeFormatted"] = formatUptime(uptimeInterval)

		return result
	}

	private func formatUptime(_ interval: TimeInterval) -> String {
		let totalSeconds = Int(interval)
		let days = totalSeconds / 86400
		let hours = (totalSeconds % 86400) / 3600
		let minutes = (totalSeconds % 3600) / 60
		let seconds = totalSeconds % 60

		var components: [String] = []
		if days > 0 {
			components.append("\(days)d")
		}
		if hours > 0 || !components.isEmpty {
			components.append("\(hours)h")
		}
		if minutes > 0 || !components.isEmpty {
			components.append("\(minutes)m")
		}
		components.append("\(seconds)s")

		return components.joined(separator: " ")
	}
}
