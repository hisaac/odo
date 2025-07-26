import Foundation

enum MemoryInfoGatherer {
	static func gatherMemoryInfo() throws -> MemoryInfo {
		// Get total physical memory
		let totalMemory = try SysctlHelpers.sysctlUInt64("hw.memsize")
		
		// Get memory statistics using vm_statistics64
		var vmStats = vm_statistics64()
		var count = mach_msg_type_number_t(MemoryLayout<vm_statistics64>.size / MemoryLayout<integer_t>.size)
		
		let result = withUnsafeMutablePointer(to: &vmStats) {
			$0.withMemoryRebound(to: integer_t.self, capacity: Int(count)) {
				host_statistics64(mach_host_self(), HOST_VM_INFO64, $0, &count)
			}
		}
		
		guard result == KERN_SUCCESS else {
			throw NSError(domain: "SystemInfoError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Failed to get memory statistics"])
		}
		
		let pageSize = UInt64(4096) // Use standard page size for macOS
		let activeBytes = UInt64(vmStats.active_count) * pageSize
		let inactiveBytes = UInt64(vmStats.inactive_count) * pageSize
		let wiredBytes = UInt64(vmStats.wire_count) * pageSize
		let compressedBytes = UInt64(vmStats.compressor_page_count) * pageSize
		
		let usedBytes = activeBytes + inactiveBytes + wiredBytes + compressedBytes
		let availableBytes = totalMemory - usedBytes
		
		// Get swap usage
		let swapUsage = try SysctlHelpers.sysctl("vm.swapusage", type: xsw_usage.self)
		
		return MemoryInfo(
			totalBytes: totalMemory,
			availableBytes: availableBytes,
			usedBytes: usedBytes,
			swapTotalBytes: swapUsage.xsu_total,
			swapUsedBytes: swapUsage.xsu_used
		)
	}
}