//
//  OrdersService.swift
//  PaymentDemo
//
//  Created by Evgeniy Leychenko on 07.02.17.
//  Copyright © 2017 theappsolutions.com. All rights reserved.
//

import UIKit

protocol OrdersService {
    
    func fetchOrders(completion: ArrayErrorCompletion?)
    func addOrder(from request: AddOrderRequestModel, completion: ObjectErrorCompletion?)
}

class DefaultOrdersService: OrdersService {
    
    private var apiManager: Networking
    
    // MARK: - Lifecycle -
    
    init(withApiManager manager: Networking) {
        apiManager = manager
    }
    
    // MARK: - Public -
    
    func fetchOrders(completion: ArrayErrorCompletion?) {
        let ordersListRequest = OrdersListRequest(token: Defaults.deviceID)
        apiManager.performRequest(request: ordersListRequest, usingValidator: nil, success: { (json) in
            guard let ordersInfo = json["orders"] as? [[String: Any]] else {
                completion?([], ResponseError.unknown)
                return
            }
            
            let orders = ordersInfo.flatMap({ Order(JSON: $0) })
            completion?(orders, nil)
        }) { (error) in
            completion?([], nil)
        }
    }
    
    func addOrder(from request: AddOrderRequestModel, completion: ObjectErrorCompletion?) {
        let addOrderRequest = AddOrderRequest(token: Defaults.deviceID, orderRequest: request)
        apiManager.performRequest(request: addOrderRequest, usingValidator: nil, success: { (json) in
            guard let orderInfo = json as? [String: Any] else {
                completion?(nil, ResponseError.unknown)
                return
            }
            
            completion?(Order(JSON: orderInfo), nil)
        }) { (error) in
            completion?(nil, error)
        }
    }
}

