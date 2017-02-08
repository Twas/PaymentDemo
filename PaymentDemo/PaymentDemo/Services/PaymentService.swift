//
//  PaymentService.swift
//  PaymentDemo
//
//  Created by Evgeniy Leychenko on 08.02.17.
//  Copyright © 2017 theappsolutions.com. All rights reserved.
//

import Foundation

protocol PaymentService {
    
    func processPayment(for orderID: Int, with cardID: String, completion: ObjectErrorCompletion?)
}

class DefaultPaymentService: PaymentService {
    
    private var apiManager: Networking
    
    // MARK: - Lifecycle -
    
    init(withApiManager manager: Networking) {
        apiManager = manager
    }
    
    // MARK: - Public -
    
    func processPayment(for orderID: Int, with cardID: String, completion: ObjectErrorCompletion?) {
        let paymentRequest = PaymentRequest(token: Defaults.deviceID, orderID: orderID, cardID: cardID)
        apiManager.performRequest(request: paymentRequest, usingValidator: nil, success: { (json) in
            guard let orderInfo = json["order"] as? [String: Any] else {
                completion?(nil, ResponseError.unknown)
                return
            }
            
            completion?(Order(JSON: orderInfo), nil)
        }) { (error) in
            completion?(nil, error)
        }
    }
}
