//
//  ProductsViewController.swift
//  PaymentDemo
//
//  Created by Evgeniy Leychenko on 06.02.17.
//  Copyright © 2017 theappsolutions.com. All rights reserved.
//

import UIKit

class ProductsViewController: UIViewController, ProductsInterface {

    // dependencies
    var presenter: ProductsOutput?
    
    @IBOutlet weak private var tableView: UITableView!
    
    private var dataDisplayManager = ProductsListDataDisplayManager()
    
    private var addButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle(Localization.Buttons.add, for: .normal)
        button.setTitleColor(UIColor.blue, for: .normal)
        button.sizeToFit()
        
        return button
    }()
    
    // MARK: - Lifecycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        performInitalSetup()
        presenter?.viewIsReady()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = false
    }
    
    // MARK: - Actions -
    
    func addAction(_ sender: UIButton) {
        presenter?.didTriggerAddProductEvent()
    }
    
    // MARK: - Products Interface -
    
    func reload(products: [Order]) {
        dataDisplayManager.reload(with: products)
    }
    
    // MARK: - Private -
    
    private func performInitalSetup() {
        addAddButton()
        
        dataDisplayManager.delegate = self
        dataDisplayManager.registerCells(for: tableView)
    }
    
    private func addAddButton() {
        addButton.addTarget(self, action: #selector(addAction(_:)), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: addButton)
    }
}

extension ProductsViewController: ProductsListDataDisplayManagerDelegate {
    
    func select(order: Order) {
        presenter?.didSelectProduct(order)
    }
}
