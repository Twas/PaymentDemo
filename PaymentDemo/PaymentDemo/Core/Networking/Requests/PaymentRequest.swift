//
//  PaymentRequest.swift
//  PaymentDemo
//
//  Created by Evgeniy Leychenko on 08.02.17.
//  Copyright © 2017 theappsolutions.com. All rights reserved.
//

import UIKit

struct PaymentRequest {
    
    var token: String
    var orderID: Int
    var cardID: String
}

extension PaymentRequest: RequestConfiguration {
    
    var method: RequestMethod { return .POST }
    var endpoint: String { return "order/\(orderID)/pay" }
    var parameters: [String : Any]? {
        return ["cardId" : cardID]
    }
    var headers: [String : String]? { return ["Authorization" : token] }
}
