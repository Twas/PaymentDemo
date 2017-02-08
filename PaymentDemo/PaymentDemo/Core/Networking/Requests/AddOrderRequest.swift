//
//  AddOrderRequest.swift
//  PaymentDemo
//
//  Created by Evgeniy Leychenko on 07.02.17.
//  Copyright © 2017 theappsolutions.com. All rights reserved.
//

import UIKit

struct AddOrderRequest {
    
    var token: String
    var orderRequest: AddOrderRequestModel
}

extension AddOrderRequest: RequestConfiguration {
    
    var method: RequestMethod { return .POST }
    var endpoint: String { return "order/create" }
    var parameters: [String : Any]? {
        return ["title" : orderRequest.title,
                "description" : orderRequest.description,
                "amount" : orderRequest.amount]
    }
    var headers: [String : String]? { return ["Authorization" : token] }
}
