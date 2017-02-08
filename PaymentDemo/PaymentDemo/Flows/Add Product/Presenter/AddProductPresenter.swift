//
//  AddProductPresenter.swift
//  PaymentDemo
//
//  Created by Evgeniy Leychenko on 08.02.17.
//  Copyright © 2017 theappsolutions.com. All rights reserved.
//

import UIKit

protocol AddProductInterface: class, DisplayingUserActivity, DisplayingError {
    
    var productTitle: String { get }
    var productDescription: String { get }
    var productAmount: String { get }
}

protocol AddProductOutput {
    
    func didTriggerAddProductEvent()
}

class AddProductPresenter: AddProductOutput {
    
    // dependencies
    weak var view: AddProductInterface?
    var router: Router?
    var ordersService: OrdersService?
    
    private var successfulCompletionHandler: Event?
    
    // MARK: - Module -
    
    static func showView(in navigationController: UINavigationController?, successHandler: Event?) {
        let addProductVC = AddProductViewController()
        
        let presenter = AddProductPresenter()
        presenter.view = addProductVC
        presenter.router = DefaultRouter()
        presenter.ordersService = Services.ordersService()
        presenter.successfulCompletionHandler = successHandler
        
        addProductVC.presenter = presenter
        
        presenter.show(in: navigationController)
    }
    
    func show(in navigationController: UINavigationController?) {
        guard let viewController = view as? UIViewController else {
            return
        }
        
        router?.show(viewController: viewController, in: navigationController, animated: true)
    }
    
    // MARK: - AddProductOutput -
    
    func didTriggerAddProductEvent() {
        guard let view = view else {
            return
        }
        
        let addProductRequest = AddOrderRequestModel(title: view.productTitle,
                                                     description: view.productDescription,
                                                     amount: floatAmount(from: view.productAmount))
        
        view.showActivity()
        ordersService?.addOrder(from: addProductRequest, completion: { [weak self] (order, error) in
            view.hideActivity()
            if order != nil {
                self?.successfulCompletionHandler?()
                self?.goBack()
            } else if let error = error {
                view.displayError(error.messages)
            }
        })
    }
    
    // MARK: - Private -
    
    private func goBack() {
        guard let viewController = view as? UIViewController else {
            return
        }
        
        router?.pop(viewController: viewController, animated: true)
    }
    
    private func floatAmount(from string: String) -> Float {
        let numberFormatter = NumberFormatter()
        numberFormatter.locale = Locale(identifier: "en_US")
        let amount = numberFormatter.number(from: string)?.floatValue
        
        return amount ?? 0.0
    }
}
