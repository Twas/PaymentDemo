//
//  DeleteCardRequest.swift
//  PaymentDemo
//
//  Created by Evgeniy Leychenko on 07.02.17.
//  Copyright © 2017 theappsolutions.com. All rights reserved.
//

import Foundation

struct DeleteCardRequest {
    
    var token: String
    var cardID: String
}

extension DeleteCardRequest: RequestConfiguration {
    
    var method: RequestMethod { return .POST }
    var endpoint: String { return "card/delete"}
    var parameters: [String : Any]? { return ["cardId" : cardID] }
    var headers: [String : String]? { return ["Authorization" : token] }
}
