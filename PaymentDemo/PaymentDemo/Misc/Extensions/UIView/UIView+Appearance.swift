//
//  UIView+Appearance.swift
//  PaymentDemo
//
//  Created by Evgeniy Leychenko on 06.02.17.
//  Copyright © 2017 theappsolutions.com. All rights reserved.
//

import UIKit

extension UIView {
    
    func makeRoundedCorners(with radius: CGFloat) {
        guard radius > 0 else {
            return
        }
        
        layer.cornerRadius = radius
        layer.masksToBounds = true
    }
    
    func addBorders(width: CGFloat, color: UIColor) {
        guard width > 0 else {
            return
        }
        
        layer.borderWidth = width
        layer.borderColor = color.cgColor
        layer.masksToBounds = true
    }
    
    func applySimpleShadow(color: UIColor) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        layer.shadowOpacity = 1
    }
}
