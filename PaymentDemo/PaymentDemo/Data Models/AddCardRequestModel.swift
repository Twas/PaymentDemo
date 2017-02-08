//
//  AddCardRequestModel.swift
//  PaymentDemo
//
//  Created by Evgeniy Leychenko on 07.02.17.
//  Copyright © 2017 theappsolutions.com. All rights reserved.
//

import Foundation

struct AddCardRequestModel {
    
    var number: String
    var cvc: String
    var expirationMonth: String
    var expirationYear: String
}
