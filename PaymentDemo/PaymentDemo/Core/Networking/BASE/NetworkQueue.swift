//
//  NetworkQueue.swift
//  LTNetworking
//
//  Created by Gleb Pavliuchenko on 8/20/16.
//  Copyright © 2016 Gleb Pavliuchenko. All rights reserved.
//

import Foundation

public final class NetworkQueue {
	static var defaultQueue: NetworkQueue = NetworkQueue()
	
	private let queue: OperationQueue
	
	public init(withOperationQueue operationQueue: OperationQueue? = nil) {
		queue = operationQueue ?? NetworkQueue.defaultOperationQueue
	}
	
	// MARK: Methods
	
	public func add(_ request: Request) {
		queue.addOperation(request.operation)
	}
	
	public func cancel(_ request: Request) {
		request.operation.cancel()
	}
	
	public func setQueuePaused(_ paused: Bool) {
		queue.isSuspended = paused
	}
}

private extension NetworkQueue {
	static var defaultOperationQueue: OperationQueue {
		let queue = OperationQueue()
		queue.name = "DefaultQueue"
		queue.maxConcurrentOperationCount = 10
		queue.qualityOfService = .background
		return queue
	}
}
