//
//  ResultMapper.swift
//  LTNetworking
//
//  Created by Gleb Pavliuchenko on 8/20/16.
//  Copyright © 2016 Gleb Pavliuchenko. All rights reserved.
//

import Foundation

protocol ResultMapper {
	associatedtype T
	func map(result: Result<AnyObject>) -> T
}
