//
//  ResponderSwitchable.swift
//  PaymentDemo
//
//  Created by Evgeniy Leychenko on 08.02.17.
//  Copyright © 2017 theappsolutions.com. All rights reserved.
//

import UIKit

protocol ResponderSwitchable {
    
    var responders: [UIResponder]? { get }
    
    func switchToNextResponder() -> Bool
    
}

extension ResponderSwitchable {
    
    func switchToNextResponder() -> Bool {
        guard let responders = responders else {
            return false
        }
        
        for (index, responder) in responders.enumerated() where responder.isFirstResponder {
            if index < responders.count - 1 {
                let nextResponder = responders[index + 1]
                return nextResponder.becomeFirstResponder()
                
            } else {
                return !responder.resignFirstResponder()
            }
        }
        return false
    }
    
}
