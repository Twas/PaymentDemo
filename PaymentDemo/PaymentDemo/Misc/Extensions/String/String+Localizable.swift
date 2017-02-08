//
//  String+Localizable.swift
//  PaymentDemo
//
//  Created by Evgeniy Leychenko on 06.02.17.
//  Copyright © 2017 theappsolutions.com. All rights reserved.
//

import Foundation

public extension NSString {
    
    public func localized() -> String {
        return NSLocalizedString(self as String, comment: "")
    }
}
