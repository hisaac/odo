import ArgumentParser
import Foundation

@main
struct odo: AsyncParsableCommand {
	static let configuration = CommandConfiguration(
		abstract: "A CLI tool for gathering system information in structured format"
	)

	@Flag(name: .shortAndLong, help: "Show verbose output")
	var verbose = false

	@Flag(name: .long, help: "Pretty print JSON output")
	var prettyPrint = false

	func run() async throws {
		print("Gathering system information...")
	}
}
