import Foundation
import Network

struct NetworkProbe: SystemProbe {
	let friendlyName = "Network Information"
	let name = "network"

	func probe() async throws -> [String: Any] {
		var result: [String: Any] = [:]
	}
}
