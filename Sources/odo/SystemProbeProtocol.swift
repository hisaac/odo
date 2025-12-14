import Foundation

protocol SystemProbe {
	var friendlyName: String { get }
	var name: String { get }
	func probe() async throws -> [String: Any]
}
