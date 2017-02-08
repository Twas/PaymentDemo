//
//  TableDataDisplayManager.swift
//  PaymentDemo
//
//  Created by Evgeniy Leychenko on 06.02.17.
//  Copyright © 2017 theappsolutions.com. All rights reserved.
//

import UIKit

protocol ReusableCell {
    static var cellID: String { get }
    static var height: CGFloat? { get }
    func setup(with object: Any)
}

protocol TableDataDisplayManager: class, UITableViewDelegate, UITableViewDataSource {
    
    associatedtype Item
    
    var items: [Item] { get set }
    var tableView: UITableView? { get set }

    func registerCells(for tableView: UITableView)
    func reload(with items: [Item])
    func item(at indexPath: IndexPath) -> Item?
}

class DefaultTableDataDisplayManager<ItemType, CellType: ReusableCell>: NSObject, TableDataDisplayManager where CellType: UITableViewCell {
    
    typealias Item = ItemType

    var items: [ItemType] = []
    var tableView: UITableView?

    func registerCells(for tableView: UITableView) {
        self.tableView = tableView

        let cellNib = UINib(nibName: CellType.cellID, bundle: nil)
        self.tableView?.register(cellNib, forCellReuseIdentifier: CellType.cellID)
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
    }
    
    func reload(with items: [Item]) {
        self.items = items
        tableView?.reloadData()
    }
   
    func item(at indexPath: IndexPath) -> Item? {
        guard indexPath.row < items.count else {
            return nil
        }
        
        return items[indexPath.row]
    }
    
    // MARK: - Table -
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CellType.height ?? UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellType.cellID) as? CellType else {
            return UITableViewCell(style: .default, reuseIdentifier: "cell")
        }
        
        if indexPath.row < items.count {
            cell.setup(with: items[indexPath.row])
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
