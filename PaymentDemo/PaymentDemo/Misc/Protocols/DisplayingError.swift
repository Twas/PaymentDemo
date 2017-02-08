//
//  DisplayingError.swift
//  PaymentDemo
//
//  Created by Evgeniy Leychenko on 07.02.17.
//  Copyright © 2017 theappsolutions.com. All rights reserved.
//

import UIKit
import PKHUD

protocol DisplayingError {
    
    func displayError(_ messages: [String])
}

extension DisplayingError where Self: UIViewController {
    
    func displayError(_ messages: [String]) {
        let errorText = messages.joined(separator: "\n")
        
        let alertController = UIAlertController(title: Localization.Alerts.errorTitle, message: errorText, preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: Localization.Buttons.ok, style: .default, handler: nil))
        
        present(alertController, animated: true, completion: nil)
    }
}

extension DisplayingError {
    
    func displayError(_ messages: [String]) {
        let errorText = messages.joined(separator: "\n")
        
        let errorContent = HUDContentType.labeledError(title: Localization.Alerts.errorTitle, subtitle: errorText)
        HUD.flash(errorContent, delay: 3)
    }
}
