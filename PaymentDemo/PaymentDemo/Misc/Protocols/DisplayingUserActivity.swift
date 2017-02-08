//
//  DisplayingUserActivity.swift
//  PaymentDemo
//
//  Created by Evgeniy Leychenko on 07.02.17.
//  Copyright © 2017 theappsolutions.com. All rights reserved.
//

import Foundation

protocol DisplayingUserActivity {
    
    func showActivity()
    func hideActivity()
}

extension DisplayingUserActivity {
    
    func showActivity() {
        ActivityIndicator.show()
    }
    
    func hideActivity() {
        ActivityIndicator.dismiss()
    }
}
