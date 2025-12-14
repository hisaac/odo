import ArgumentParser
import Foundation

@main
struct odo: AsyncParsableCommand {
	static let configuration = CommandConfiguration(
		abstract: "A CLI tool for gathering system information in structured format"
	)

	@Flag(name: .shortAndLong, help: "Show verbose output")
	var verbose = false

	@Flag(name: .long, help: "Do not pretty print JSON output")
	var noPrettyPrint = false

	@MainActor
	func run() async throws {
		let probes: [any SystemProbe] = [
			DiskProbe(),
			NetworkProbe(),
			OperatingSystemProbe(),
			UptimeProbe(),
		]

		if verbose {
			print("Gathering system information...")
		}

		var results: [String: [String: Any]] = [:]

		for probe in probes {
			if verbose {
				print("Running probe: \(probe.name)")
			}
			let data = try await probe.probe()
			results[probe.name] = data
		}

		let jsonData = try JSONSerialization.data(
			withJSONObject: results,
			options: noPrettyPrint ? [.sortedKeys] : [.prettyPrinted, .sortedKeys]
		)

		if let jsonString = String(data: jsonData, encoding: .utf8) {
			print(jsonString)
		}
	}
}
