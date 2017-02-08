//
//  Navigatable.swift
//  PaymentDemo
//
//  Created by Evgeniy Leychenko on 06.02.17.
//  Copyright © 2017 theappsolutions.com. All rights reserved.
//

import UIKit

protocol Navigatable: class {
    
    var navigationController: UINavigationController? { get }
}
