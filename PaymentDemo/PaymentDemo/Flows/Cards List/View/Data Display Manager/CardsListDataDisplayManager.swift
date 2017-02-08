//
//  CardsListDataDisplayManager.swift
//  PaymentDemo
//
//  Created by Evgeniy Leychenko on 07.02.17.
//  Copyright © 2017 theappsolutions.com. All rights reserved.
//

import UIKit

protocol CardsListDataDisplayManagerDelegate: class {
    
    func delete(card: Card)
    func select(card: Card)
}

class CardsListDataDisplayManager: DefaultTableDataDisplayManager<Card, CardTableViewCell> {
    
    weak var delegate: CardsListDataDisplayManagerDelegate?
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = super.tableView(tableView, cellForRowAt: indexPath) as? CardTableViewCell else {
            return UITableViewCell(style: .default, reuseIdentifier: "cell")
        }
        
        if indexPath.row < items.count {
            cell.longPressHandler = { [weak self] in
                self?.deleteCard(at: indexPath)
            }
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        super.tableView(tableView, didSelectRowAt: indexPath)
        
        guard indexPath.row < items.count else {
            return
        }
        
        delegate?.select(card: items[indexPath.row])
    }
    
    // MARK: - Private -
    
    private func deleteCard(at indexPath: IndexPath) {
        guard indexPath.row < items.count else {
            return
        }
        
        delegate?.delete(card: items[indexPath.row])
    }
}
