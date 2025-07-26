import ArgumentParser
import Foundation

@main
struct odo: ParsableCommand {
	static let configuration = CommandConfiguration(
		abstract: "A CLI tool for gathering system information in structured format"
	)

	@Flag(name: .shortAndLong, help: "Show verbose output")
	var verbose = false

	@Flag(name: .long, help: "Pretty print JSON output")
	var prettyPrint = false

	func run() throws {
		let systemInfo = try gatherSystemInfo()
		let jsonData = try encodeToJSON(systemInfo)
		
		if let jsonString = String(data: jsonData, encoding: .utf8) {
			print(jsonString)
		}
	}
	
	private func gatherSystemInfo() throws -> SystemInfo {
		let cpu = try CPUInfoGatherer.gatherCPUInfo()
		let memory = try MemoryInfoGatherer.gatherMemoryInfo()
		let storage = try StorageInfoGatherer.gatherStorageInfo(verbose: verbose)
		let network = try NetworkInfoGatherer.gatherNetworkInfo()
		
		return SystemInfo(cpu: cpu, memory: memory, storage: storage, network: network)
	}
	
	private func encodeToJSON(_ systemInfo: SystemInfo) throws -> Data {
		let encoder = JSONEncoder()
		if prettyPrint {
			encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
		}
		return try encoder.encode(systemInfo)
	}
}