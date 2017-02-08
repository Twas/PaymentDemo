//
//  Request.swift
//  LTNetworking
//
//  Created by Gleb Pavliuchenko on 8/20/16.
//  Copyright © 2016 Gleb Pavliuchenko. All rights reserved.
//

import Foundation

public final class Request {
	
	lazy private var queue: OperationQueue = Request.responseProcessingQueue()
	let operation: NetworkRequestOperation
	var result: Result<AnyObject>?
	
	required public init(withNetworkOperation operation: NetworkRequestOperation) {
		self.operation = operation 
		self.operation.completion = { operationResult in
			self.result = operationResult
			self.queue.isSuspended = false
		}
	}
	
	public func validateResult(withValidator validator: ResponseValidator) -> Request {
		queue.addOperation {
			if self.result != nil {
				self.result = validator.validate(result: self.result!)
			}
		}
		return self
	}
	
	public func onSuccess(_ clossure: @escaping (AnyObject) -> Void) -> Request {
		queue.addOperation {
			switch self.result! {
			case .success(let value):
				clossure(value)
			case .failure(_):
				break
			}
		}
		return self
	}
	
	public func onFailure(_ clossure: @escaping (Error) -> Void) -> Request {
		queue.addOperation {
			switch self.result! {
			case .success(_):
				break
			case .failure(let error):
				clossure(error)
			}
		}
		return self
	}
	
	public func onComplete(_ completion: @escaping (Result<AnyObject>) -> Void) {
		queue.addOperation {
            DispatchQueue.main.async(execute: { 
                completion(self.result!)
            })
		}
	}
}

public extension Request {
	public static func responseProcessingQueue() -> OperationQueue {
		let queue = OperationQueue()
		queue.maxConcurrentOperationCount = 1
		queue.name = "responseProcessingQueue"
		queue.qualityOfService = .userInteractive
		queue.isSuspended = true
		return queue
	}
}
