import Foundation

struct DiskProbe: SystemProbe {
	let friendlyName = "Disk Information"
	let name = "disk"

	@MainActor
	func probe() async throws -> [String: Any] {
		var result: [String: Any] = [:]
		let fileURL = URL(fileURLWithPath: NSHomeDirectory())
		let values = try fileURL.resourceValues(forKeys: [
			.volumeAvailableCapacityKey,
			.volumeTotalCapacityKey,
			.volumeNameKey,
			.volumeIsRemovableKey,
			.volumeIsInternalKey,
		])

		if let capacity = values.volumeTotalCapacity,
			let available = values.volumeAvailableCapacity
		{
			let formatter = ByteCountFormatter()
			formatter.countStyle = .file

			let totalString = formatter.string(fromByteCount: Int64(capacity))
			let availableString = formatter.string(fromByteCount: Int64(available))
			result["totalCapacityBytes"] = capacity
			result["availableCapacityBytes"] = available
			result["totalCapacityFormatted"] = totalString
			result["availableCapacityFormatted"] = availableString
		}
		return result
	}
}
