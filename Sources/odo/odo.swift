import ArgumentParser
import Foundation

@main
struct odo: ParsableCommand {
	static let configuration = CommandConfiguration(
		abstract: "A CLI tool for managing system configuration from YAML files"
	)

	@Argument(help: "Path to the YAML configuration file")
	var configPath: String

	@Flag(name: .shortAndLong, help: "Show verbose output")
	var verbose = false

	@Flag(name: .shortAndLong, help: "Show what would be changed without making changes")
	var dryRun = false

	mutating func run() throws {

	}
}
