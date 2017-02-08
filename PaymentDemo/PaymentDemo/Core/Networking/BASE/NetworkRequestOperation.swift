//
//  NetworkRequestOperation.swift
//  LTNetworking
//
//  Created by Gleb Pavliuchenko on 8/20/16.
//  Copyright © 2016 Gleb Pavliuchenko. All rights reserved.
//

import Foundation

public class NetworkRequestOperation: AsyncOperation {
	
	private let baseURL: URL
	var completion: ((Result<AnyObject>) -> Void)?
	let configuration: RequestConfiguration
	
	required public init(withConfiguration config: RequestConfiguration, baseURL: URL) {
		configuration = config
		self.baseURL = baseURL
	}
	
	override public func start() {
		super.start()
		self.startRequest(withCompletionHandler: completion)
	}
	
	func startRequest(withCompletionHandler completion: ((Result<AnyObject>) -> Void)? = nil) {
		fatalError("This method should be ovveridden in subclasses")
	}
	
	func buildURL() -> URL {
        return baseURL.appendingPathComponent(configuration.endpoint)
	}
}
