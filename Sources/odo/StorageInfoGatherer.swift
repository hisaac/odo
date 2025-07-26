import Foundation

enum StorageInfoGatherer {
	static func gatherStorageInfo(verbose: Bool = false) throws -> StorageInfo {
		let fileManager = FileManager.default
		var devices: [StorageDevice] = []
		
		// Get mounted volumes
		let urls = fileManager.mountedVolumeURLs(includingResourceValuesForKeys: [
			.volumeNameKey,
			.volumeTotalCapacityKey,
			.volumeAvailableCapacityKey,
			.volumeResourceCountKey
		], options: [.skipHiddenVolumes])
		
		for url in urls ?? [] {
			do {
				let resourceValues = try url.resourceValues(forKeys: [
					.volumeNameKey,
					.volumeTotalCapacityKey,
					.volumeAvailableCapacityKey
				])
				
				let name = resourceValues.volumeName ?? "Unknown"
				let totalBytes = UInt64(resourceValues.volumeTotalCapacity ?? 0)
				let availableBytes = UInt64(resourceValues.volumeAvailableCapacity ?? 0)
				let usedBytes = totalBytes - availableBytes
				let filesystem = "Unknown" // fileSystemTypeName not available in this API
				let mountPoint = url.path
				
				let device = StorageDevice(
					name: name,
					totalBytes: totalBytes,
					availableBytes: availableBytes,
					usedBytes: usedBytes,
					filesystem: filesystem,
					mountPoint: mountPoint
				)
				
				devices.append(device)
			} catch {
				if verbose {
					fputs("Warning: Could not get information for volume at \(url): \(error)\n", stderr)
				}
			}
		}
		
		return StorageInfo(devices: devices)
	}
}