//
//  RequestParametrs.swift
//  LTNetworking
//
//  Created by Gleb Pavliuchenko on 8/20/16.
//  Copyright © 2016 Gleb Pavliuchenko. All rights reserved.
//

import UIKit

public enum RequestMethod: String {
	case OPTIONS, GET, HEAD, POST, PUT, PATCH, DELETE, TRACE, CONNECT
}

//requestConfiguration
public protocol RequestConfiguration {
    
    typealias MultipartFormDataImages = (images: [UIImage], parameterName: String)
    
	var method: RequestMethod { get }
	var endpoint: String { get }
	var parameters: [String : Any]? { get }
	var headers: [String : String]? { get }
    var multipartImages: MultipartFormDataImages? { get }
}

public extension RequestConfiguration {
	var parameters: [String : Any]? { return nil }
	var headers: [String : String]? { return nil }
    var multipartImages: MultipartFormDataImages? { return nil }
}
