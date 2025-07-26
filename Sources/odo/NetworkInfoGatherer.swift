import Foundation

enum NetworkInfoGatherer {
	static func gatherNetworkInfo() throws -> NetworkInfo {
		var interfaces: [NetworkInterface] = []
		
		var ifap: UnsafeMutablePointer<ifaddrs>?
		guard getifaddrs(&ifap) == 0 else {
			throw NSError(domain: "SystemInfoError", code: 2, userInfo: [NSLocalizedDescriptionKey: "Failed to get network interfaces"])
		}
		
		defer {
			freeifaddrs(ifap)
		}
		
		var interfaceMap: [String: NetworkInterface] = [:]
		
		var current = ifap
		while current != nil {
			defer { current = current?.pointee.ifa_next }
			
			guard let addr = current?.pointee else { continue }
			let name = String(cString: addr.ifa_name)
			
			// Skip loopback and non-active interfaces for cleaner output
			let isUp = (addr.ifa_flags & UInt32(IFF_UP)) != 0
			
			var interface = interfaceMap[name] ?? NetworkInterface(
				name: name,
				isUp: isUp,
				ipv4Addresses: [],
				ipv6Addresses: [],
				macAddress: nil
			)
			
			if let sockaddr = addr.ifa_addr {
				switch Int32(sockaddr.pointee.sa_family) {
				case AF_INET:
					var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
					if getnameinfo(sockaddr, socklen_t(MemoryLayout<sockaddr_in>.size),
								   &hostname, socklen_t(hostname.count),
								   nil, 0, NI_NUMERICHOST) == 0 {
						interface.ipv4Addresses.append(String(decoding: hostname.prefix(while: { $0 != 0 }).map { UInt8(bitPattern: $0) }, as: UTF8.self))
					}
					
				case AF_INET6:
					var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
					if getnameinfo(sockaddr, socklen_t(MemoryLayout<sockaddr_in6>.size),
								   &hostname, socklen_t(hostname.count),
								   nil, 0, NI_NUMERICHOST) == 0 {
						interface.ipv6Addresses.append(String(decoding: hostname.prefix(while: { $0 != 0 }).map { UInt8(bitPattern: $0) }, as: UTF8.self))
					}
					
				case AF_LINK:
					let linkAddr = sockaddr.withMemoryRebound(to: sockaddr_dl.self, capacity: 1) { $0.pointee }
					if linkAddr.sdl_alen == 6 { // MAC address length
						let macBytes = withUnsafePointer(to: linkAddr) { ptr in
							ptr.withMemoryRebound(to: UInt8.self, capacity: MemoryLayout<sockaddr_dl>.size) { bytes in
								Array(UnsafeBufferPointer(start: bytes.advanced(by: Int(linkAddr.sdl_nlen) + Int(linkAddr.sdl_alen) - 6), count: 6))
							}
						}
						interface.macAddress = String(format: "%02x:%02x:%02x:%02x:%02x:%02x",
													  macBytes[0], macBytes[1], macBytes[2],
													  macBytes[3], macBytes[4], macBytes[5])
					}
					
				default:
					break
				}
			}
			
			interfaceMap[name] = interface
		}
		
		interfaces = Array(interfaceMap.values).sorted { $0.name < $1.name }
		
		return NetworkInfo(interfaces: interfaces)
	}
}