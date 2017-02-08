//
//  Cart.swift
//  PaymentDemo
//
//  Created by Evgeniy Leychenko on 08.02.17.
//  Copyright © 2017 theappsolutions.com. All rights reserved.
//

import UIKit

protocol Cart: class {
    
    var product: Order? { get set }
    var card: Card? { get set }
    
    func commitPurchase(completion: ObjectErrorCompletion?)
}

class DefaultCart: Cart  {
    
    var product: Order?
    var card: Card?
    
    private var paymentService: PaymentService
    
    // MARK: - Lifecycle -
    
    init(with paymentService: PaymentService) {
        self.paymentService = paymentService
    }
    
    func commitPurchase(completion: ObjectErrorCompletion?) {
        guard let product = product,
            let card = card else {
                completion?(nil, ResponseError.unknown)
                return
        }
        
        paymentService.processPayment(for: product.id, with: card.id, completion: completion)
    }
}
