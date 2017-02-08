//
//  ActivityIndicator.swift
//  PaymentDemo
//
//  Created by Evgeniy Leychenko on 07.02.17.
//  Copyright © 2017 theappsolutions.com. All rights reserved.
//

import UIKit
import PKHUD

class ActivityIndicator {
    
    static func show() {
        HUD.show(.progress)
    }
    
    static func dismiss() {
        HUD.hide(animated: true)
    }
}
