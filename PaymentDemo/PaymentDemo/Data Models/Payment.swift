//
//  Payment.swift
//  PaymentDemo
//
//  Created by Evgeniy Leychenko on 07.02.17.
//  Copyright © 2017 theappsolutions.com. All rights reserved.
//

import Foundation
import ObjectMapper

enum PaymentStatus: String {
    case pending = "pending"
    case success = "succeeded"
    case failed = "failed"
    
    func colorRepresentation() -> UIColor {
        switch self {
        case .pending:
            return UIColor.green
        case .success:
            return UIColor.blue
        case .failed:
            return UIColor.red
        }
    }
    
    func stringRepresentation() -> String {
        return rawValue.capitalized
    }
}

class Payment: Mappable {
    
    var id: Int = -1
    var status: PaymentStatus?
    
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        status <- map["status"]
    }
}
