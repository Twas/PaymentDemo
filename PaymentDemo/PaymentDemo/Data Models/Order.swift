//
//  Order.swift
//  PaymentDemo
//
//  Created by Evgeniy Leychenko on 07.02.17.
//  Copyright © 2017 theappsolutions.com. All rights reserved.
//

import Foundation
import ObjectMapper

enum OrderStatus: String {
    case pending = "pending"
    case payed = "payed"
    
    func colorRepresentation() -> UIColor {
        switch self {
        case .pending:
            return UIColor.green
        case .payed:
            return UIColor.red
        }
    }
    
    func stringRepresentation() -> String {
        return rawValue.capitalized
    }
}

class Order: Mappable {
    
    var id: Int = -1
    var title: String = ""
    var description: String = ""
    var amount: Float = 0.0
    var status: OrderStatus?
    var payment: Payment?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        description <- map["description"]
        amount <- map["amount"]
        status <- map["status"]
        payment <- map["payment"]
    }
    
    // MARK: - Public -
    
    func stringAmount() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = Locale(identifier: "en_US")
        return numberFormatter.string(from: NSNumber(value: amount)) ?? ""
    }
}
