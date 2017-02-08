//
//  ProductsPresenter.swift
//  PaymentDemo
//
//  Created by Evgeniy Leychenko on 06.02.17.
//  Copyright © 2017 theappsolutions.com. All rights reserved.
//

import UIKit

protocol ProductsInterface: Navigatable, DisplayingUserActivity {
    
    func reload(products: [Order])
}

protocol ProductsOutput {
    
    func viewIsReady()
    
    func didTriggerAddProductEvent()
    func didSelectProduct(_ order: Order)
}

class ProductsPresenter: ProductsOutput {
    
    // dependencies
    weak var view: ProductsInterface?
    var router: Router?
    var ordersService: OrdersService?
    
    // MARK: - Module -
    
    static func showView(in navigationController: UINavigationController?) {
        let productsVC = ProductsViewController()
        
        let presenter = ProductsPresenter()
        presenter.view = productsVC
        presenter.router = DefaultRouter()
        presenter.ordersService = Services.ordersService()
        
        productsVC.presenter = presenter
        
        presenter.show(in: navigationController)
    }
    
    func show(in navigationController: UINavigationController?) {
        guard let viewController = view as? UIViewController else {
            return
        }
        
        router?.show(viewController: viewController, in: navigationController, animated: true)
    }
    
    // MARK: - Products Output -
    
    func viewIsReady() {
        updateProductsList()
    }
    
    func didTriggerAddProductEvent() {
        AddProductPresenter.showView(in: view?.navigationController, successHandler: productSuccessfullyAddedEvent)
    }
    
    func didSelectProduct(_ order: Order) {
        let cart = Services.cart()
        cart.product = order
        
        CardsPresenter.showView(in: view?.navigationController, using: cart)
    }
    
    // MARK: - Private -
    
    private func productSuccessfullyAddedEvent() {
        updateProductsList()
    }
    
    private func updateProductsList() {
        view?.showActivity()
        ordersService?.fetchOrders(completion: { [weak self] (orders, _) in
            self?.view?.hideActivity()
            if let orders = orders as? [Order] {
                self?.view?.reload(products: orders)
            }
        })
    }
}
