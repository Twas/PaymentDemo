//
//  NetworkConfiguration.swift
//  LTNetworking
//
//  Created by Gleb Pavliuchenko on 8/20/16.
//  Copyright © 2016 Gleb Pavliuchenko. All rights reserved.
//

import Foundation

public final class NetworkConfiguration {
	
	let baseURL: URL
	
	public init(withBaseURL url: URL) {
		baseURL = url
	}
}

/// You should setup shared configuration manualy

public extension NetworkConfiguration {
	static var shared: NetworkConfiguration!
}
