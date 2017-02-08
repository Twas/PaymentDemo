//
//  RecipePresenter.swift
//  PaymentDemo
//
//  Created by Evgeniy Leychenko on 08.02.17.
//  Copyright © 2017 theappsolutions.com. All rights reserved.
//

import UIKit

protocol RecipeInterface: Navigatable, DisplayingUserActivity, DisplayingError {
    
    func set(productTitle: String?)
    func set(productPrice: String?)
    func set(cardBrandImage: UIImage?)
    func set(cardNumber: String?)
}

protocol RecipeOutput {
    
    func viewIsReady()
    
    func didTriggerPurchaseEvent()
}

class RecipePresenter: RecipeOutput {
    
    // dependencies
    weak var view: RecipeInterface?
    var router: Router?
    var cart: Cart
    
    // MARK: - Lifecycle -
    
    init(with cart: Cart) {
        self.cart = cart
    }
    
    // MARK: - Module -
    
    static func showView(in navigationController: UINavigationController?, using cart: Cart) {
        let recipeVC = RecipeViewController()
        
        let presenter = RecipePresenter(with: cart)
        presenter.view = recipeVC
        presenter.router = DefaultRouter()
        
        recipeVC.presenter = presenter
        
        presenter.show(in: navigationController)
    }
    
    func show(in navigationController: UINavigationController?) {
        guard let viewController = view as? UIViewController else {
            return
        }
        
        router?.show(viewController: viewController, in: navigationController, animated: true)
    }
    
    // MARK: - RecipeOutput -
    
    func viewIsReady() {
        guard let card = cart.card,
            let product = cart.product else {
            return
        }
        updateView(withProduct: product, card: card)
    }
    
    func didTriggerPurchaseEvent() {
        view?.showActivity()
        cart.commitPurchase { [weak self] (_, error) in
            self?.view?.hideActivity()
            if let error = error {
                self?.view?.displayError(error.messages)
            } else {
                self?.router?.popToRootViewController(in: self?.view?.navigationController, animated: true)
            }
        }
    }
    
    // MARK: - Private -
    
    private func updateView(withProduct product: Order, card: Card) {
        view?.set(productTitle: product.title)
        view?.set(productPrice: product.stringAmount())
        view?.set(cardBrandImage: card.brand?.imageRepresentation())
        view?.set(cardNumber: card.cardNumber)
    }
}
