//
//  AlamofierRequestOperation.swift
//  LTNetworking
//
//  Created by Gleb Pavliuchenko on 8/20/16.
//  Copyright © 2016 Gleb Pavliuchenko. All rights reserved.
//

import Foundation
import Alamofire

public final class AlamofireRequestOperation: NetworkRequestOperation {
	
	var request: Alamofire.Request?
	
	override func startRequest(withCompletionHandler completion: ((Result<AnyObject>) -> Void)?) {
        request = Alamofire.request(buildURL(),
                                    method: HTTPMethod(rawValue: configuration.method.rawValue)!,
                                    parameters: configuration.parameters,
                                    encoding: encoding(forMethod: configuration.method),
                                    headers: configuration.headers)
            .validate()
            .responseJSON { response in
                completion?(response.internalResult())
                self.finish()
        }
	}
	
	override public var isCancelled: Bool {
		didSet {
            request?.cancel()
		}
	}
    
    // MARK: - Private -
    
    func encoding(forMethod method: RequestMethod) -> ParameterEncoding {
        if configuration.method == .GET ||
            configuration.method == .HEAD ||
            configuration.method == .DELETE {
            return URLEncoding.default
        }
        
        return JSONEncoding.default
    }
}

private extension DataResponse {
	func internalResult() -> Result<AnyObject> {
		switch self.result {
		case .success(let value):
            return Result.success(value as AnyObject)
		case .failure(let error):
			print(error)
			return Result.failure(error)
		}
	}
}
