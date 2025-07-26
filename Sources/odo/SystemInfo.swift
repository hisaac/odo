import Foundation

struct SystemInfo: Codable {
	let cpu: CPUInfo
	let memory: MemoryInfo
	let storage: StorageInfo
	let network: NetworkInfo
}

struct CPUInfo: Codable {
	let model: String
	let cores: Int
	let physicalCores: Int
	let frequency: Double?
	let architecture: String
}

struct MemoryInfo: Codable {
	let totalBytes: UInt64
	let availableBytes: UInt64
	let usedBytes: UInt64
	let swapTotalBytes: UInt64
	let swapUsedBytes: UInt64
}

struct StorageInfo: Codable {
	let devices: [StorageDevice]
}

struct StorageDevice: Codable {
	let name: String
	let totalBytes: UInt64
	let availableBytes: UInt64
	let usedBytes: UInt64
	let filesystem: String
	let mountPoint: String
}

struct NetworkInfo: Codable {
	let interfaces: [NetworkInterface]
}

struct NetworkInterface: Codable {
	let name: String
	let isUp: Bool
	var ipv4Addresses: [String]
	var ipv6Addresses: [String]
	var macAddress: String?
}
