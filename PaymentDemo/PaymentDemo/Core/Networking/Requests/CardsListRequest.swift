//
//  CardsListRequest.swift
//  PaymentDemo
//
//  Created by Evgeniy Leychenko on 07.02.17.
//  Copyright © 2017 theappsolutions.com. All rights reserved.
//

import Foundation

struct CardsListRequest {
    
    var token: String
}

extension CardsListRequest: RequestConfiguration {
    
    var method: RequestMethod { return .GET }
    var endpoint: String { return "card/list/" }
    var headers: [String : String]? { return ["Authorization" : token] }
}
