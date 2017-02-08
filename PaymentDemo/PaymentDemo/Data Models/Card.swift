//
//  Card.swift
//  PaymentDemo
//
//  Created by Evgeniy Leychenko on 06.02.17.
//  Copyright © 2017 theappsolutions.com. All rights reserved.
//

import Foundation
import ObjectMapper

enum CardBrand: String {
    case visa = "Visa"
    case masterCard = "MasterCard"
    case americanExpress = "American Express"
    case other = "Other"
    
    func imageRepresentation() -> UIImage? {
        switch self {
        case .visa:
            return UIImage(named: "card_brand_visa")
        case .masterCard:
            return UIImage(named: "card_brand_master_card")
        case .americanExpress:
            return UIImage(named: "card_brand_american_express")
        case .other:
            return UIImage(named: "card_brand_other")
        }
    }
}

enum CVCCheck: String {
    case pass = "pass"
    case fail = "fail"
    case unavailable = "unavailable"
    case unchecked = "unchecked"
}

class Card: Mappable {
    
    var id: String = ""
    var brand: CardBrand?
    var cvcCheck: CVCCheck?
    var cardNumber: String = ""
        
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        brand <- map["brand"]
        cvcCheck <- map["cvc_check"]
        cardNumber <- map["last4"]
    }
}
