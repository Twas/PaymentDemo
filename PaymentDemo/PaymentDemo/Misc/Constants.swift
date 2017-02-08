//
//  Constants.swift
//  PaymentDemo
//
//  Created by Evgeniy Leychenko on 03.02.17.
//  Copyright © 2017 theappsolutions.com. All rights reserved.
//

import UIKit

typealias ArrayErrorCompletion = ([AnyObject], ServerError?) -> Void
typealias ObjectErrorCompletion = (AnyObject?, ServerError?) -> Void
typealias AuthErrorCompletion = (AnyObject?, String?, ServerError?) -> Void

typealias InputHandler = (String) -> Void
typealias Event = (Void) -> Void

struct Defaults {
    
    static let animationDuration: Double = 0.25
    static let buttonCornerRadius: CGFloat = 5.0
    static let deviceID = UIDevice.current.identifierForVendor?.uuidString ?? ""
}

struct API {
    
    static let host = devHost
    static let devHost = "http://payment-integration.dev01.theappsolutions.com/api/"
}

struct Localization {
    struct Buttons {
        static let add = "button.add".localized()
        static let ok = "button.ok".localized()
        static let yes = "button.yes".localized()
        static let no = "button.no".localized()
    }
    
    struct Alerts {
        static let errorTitle = "alert.error.title".localized()
        static let deleteCardMessage = "alert.delete_card.message".localized()
    }
    
    struct Products {
        static let paymentUnavailable = "products_list.payment.unavailable".localized()
    }
}
