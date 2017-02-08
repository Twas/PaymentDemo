//
//  AddCardRequest.swift
//  PaymentDemo
//
//  Created by Evgeniy Leychenko on 07.02.17.
//  Copyright © 2017 theappsolutions.com. All rights reserved.
//

import Foundation

struct AddCardRequest {
    
    var token: String
    var cardRequest: AddCardRequestModel
}

extension AddCardRequest: RequestConfiguration {
    
    var method: RequestMethod { return .POST }
    var endpoint: String { return "card/add" }
    var parameters: [String : Any]? {
        return ["number" : cardRequest.number,
                "cvc" : cardRequest.cvc,
                "expMonth" : cardRequest.expirationMonth,
                "expYear" : cardRequest.expirationYear]
    }
    var headers: [String : String]? { return ["Authorization" : token] }
}
