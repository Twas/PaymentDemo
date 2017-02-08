//
//  Result.swift
//  LTNetworking
//
//  Created by Gleb Pavliuchenko on 8/20/16.
//  Copyright © 2016 Gleb Pavliuchenko. All rights reserved.
//

import Foundation

public enum Result<Value> {
	case success(Value)
	case failure(Error)
	
	func map<Value>(mapper: ((Result) -> Value)) -> Value {
		return mapper(self)
	}
	
	func flatMap<U>(transform: (Value) -> Result<U>) -> Result<U> {
		switch self {
			case .success(let val): return transform(val)
			case .failure(let e): return .failure(e)
		}
	}
}

public protocol ResponseValidator {
	func validate(result: Result<AnyObject>) -> Result<AnyObject>
}
