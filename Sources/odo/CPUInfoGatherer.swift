import Foundation

enum CPUInfoGatherer {
	static func gatherCPUInfo() throws -> CPUInfo {
		let model = try SysctlHelpers.sysctlString("machdep.cpu.brand_string")
		let logicalCores = try SysctlHelpers.sysctlInt("hw.logicalcpu")
		let physicalCores = try SysctlHelpers.sysctlInt("hw.physicalcpu")
		let architecture = try SysctlHelpers.sysctlString("hw.targettype")
		// CPU frequency might not be available on all systems
		let frequency: UInt64? = try? SysctlHelpers.sysctlUInt64("hw.cpufrequency_max")
		return CPUInfo(
			model: model.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines),
			cores: logicalCores,
			physicalCores: physicalCores,
			frequency: frequency.map(Double.init),
			architecture: architecture
		)
	}
}
