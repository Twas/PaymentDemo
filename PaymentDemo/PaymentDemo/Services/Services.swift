//
//  Services.swift
//  PaymentDemo
//
//  Created by Evgeniy Leychenko on 06.02.17.
//  Copyright © 2017 theappsolutions.com. All rights reserved.
//

import Foundation

class Services {
    
    static func cardsServise() -> CardsService {
        return DefaultCardsService(withApiManager: APIManager.shared)
    }
    
    static func ordersService() -> OrdersService {
        return DefaultOrdersService(withApiManager: APIManager.shared)
    }
    
    static func paymentService() -> PaymentService {
        return DefaultPaymentService(withApiManager: APIManager.shared)
    }
    
    static func cart() -> Cart {
        return DefaultCart(with: paymentService())
    }
}
