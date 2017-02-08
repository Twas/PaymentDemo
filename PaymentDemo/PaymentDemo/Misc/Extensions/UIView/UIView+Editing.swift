//
//  UIView+Editing.swift
//  PaymentDemo
//
//  Created by Evgeniy Leychenko on 08.02.17.
//  Copyright © 2017 theappsolutions.com. All rights reserved.
//

import UIKit

extension UIView {
    
    func enableResignEditingOnTap() {
        let handleTapSelector = #selector(UIView.handleResigningTap(_:))
        let resigningGestureRecognizer = UITapGestureRecognizer(target: self, action: handleTapSelector)
        resigningGestureRecognizer.cancelsTouchesInView = false
        addGestureRecognizer(resigningGestureRecognizer)
    }
    
    // MARK: - Actions -
    
    func handleResigningTap(_ sender: UITapGestureRecognizer) {
        endEditing(true)
    }
}
