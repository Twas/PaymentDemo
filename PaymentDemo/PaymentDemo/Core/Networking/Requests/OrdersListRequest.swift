//
//  OrdersListRequest.swift
//  PaymentDemo
//
//  Created by Evgeniy Leychenko on 07.02.17.
//  Copyright © 2017 theappsolutions.com. All rights reserved.
//

import Foundation

struct OrdersListRequest {
    
    var token: String
}

extension OrdersListRequest: RequestConfiguration {
    
    var method: RequestMethod { return .GET }
    var endpoint: String { return "order/list" }
    var headers: [String : String]? { return ["Authorization" : token] }
}
