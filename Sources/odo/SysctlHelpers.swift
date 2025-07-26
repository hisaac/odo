import Foundation

enum SysctlHelpers {
	static func sysctl<T>(_ name: String, type: T.Type) throws -> T {
		var size = MemoryLayout<T>.size
		let value = UnsafeMutablePointer<T>.allocate(capacity: 1)
		defer { value.deallocate() }

		let result = sysctlbyname(name, value, &size, nil, 0)
		guard result == 0 else {
			throw NSError(
				domain: "SysctlError", code: Int(result),
				userInfo: [NSLocalizedDescriptionKey: "Failed to get sysctl value for \(name)"])
		}

		return value.pointee
	}

	static func sysctlString(_ name: String) throws -> String {
		var size = 0
		sysctlbyname(name, nil, &size, nil, 0)

		var buffer = [CChar](repeating: 0, count: size)
		let result = sysctlbyname(name, &buffer, &size, nil, 0)

		guard result == 0 else {
			throw NSError(
				domain: "SysctlError", code: Int(result),
				userInfo: [NSLocalizedDescriptionKey: "Failed to get sysctl string for \(name)"])
		}

		return String(
			decoding: buffer.prefix(while: { $0 != 0 }).map { UInt8(bitPattern: $0) }, as: UTF8.self
		)
	}

	static func sysctlInt32(_ name: String) throws -> Int32 {
		try sysctl(name, type: Int32.self)
	}

	static func sysctlUInt64(_ name: String) throws -> UInt64 {
		try sysctl(name, type: UInt64.self)
	}

	static func sysctlInt(_ name: String) throws -> Int {
		Int(try sysctlInt32(name))
	}
}
