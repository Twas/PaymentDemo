//
//  RequestManager.swift
//  LTNetworking
//
//  Created by Gleb Pavliuchenko on 8/20/16.
//  Copyright © 2016 Gleb Pavliuchenko. All rights reserved.
//

import Foundation

public class RequestManager {
	
	private let config: NetworkConfiguration
	private let queue: NetworkQueue
    
    // MARK: - Public -
	
	public init(withConfigaration configuration: NetworkConfiguration,
	                       networkQueue: NetworkQueue? = NetworkQueue.defaultQueue) {
		config = configuration
		queue = networkQueue!
	}
	
	public func performRequest(_ requestConfig: RequestConfiguration) -> Request {
		let operation = AlamofireRequestOperation(withConfiguration: requestConfig, baseURL: config.baseURL)
		return performRequest(with: operation)
	}
    
    public func performMultipartImagesRequest(_ requestConfig: RequestConfiguration) -> Request {
        let operation = AlamofireMultipartImagesRequestOperation(withConfiguration: requestConfig, baseURL: config.baseURL)
        return performRequest(with: operation)
    }
	
	func cancelRequest(_ request: Request) {
		queue.cancel(request)
	}
    
    // MARK: - Private -
    
    private func performRequest(with operation: NetworkRequestOperation) -> Request {
        let request = Request(withNetworkOperation: operation)
        queue.add(request)
        return request
    }
    
}

extension RequestManager {
	static var shared: RequestManager!
}
