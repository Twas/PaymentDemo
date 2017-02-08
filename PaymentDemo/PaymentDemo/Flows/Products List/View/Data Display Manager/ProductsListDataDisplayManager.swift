//
//  ProductsListDataDisplayManager.swift
//  PaymentDemo
//
//  Created by Evgeniy Leychenko on 08.02.17.
//  Copyright © 2017 theappsolutions.com. All rights reserved.
//

import UIKit

protocol ProductsListDataDisplayManagerDelegate: class {
    
    func select(order: Order)
}

class ProductsListDataDisplayManager: DefaultTableDataDisplayManager<Order, OrderTableViewCell> {
    
    weak var delegate: ProductsListDataDisplayManagerDelegate?
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        super.tableView(tableView, didSelectRowAt: indexPath)
        
        guard indexPath.row < items.count else {
            return
        }
        
        delegate?.select(order: items[indexPath.row])
    }
}
