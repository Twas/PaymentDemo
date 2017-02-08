//
//  StartScreenPresenter.swift
//  PaymentDemo
//
//  Created by Evgeniy Leychenko on 03.02.17.
//  Copyright © 2017 theappsolutions.com. All rights reserved.
//

import UIKit

protocol StartInterface: Navigatable {
    
}

protocol StartOutput {
    
    func didTriggerProductsEvent()
    func didTriggerCardsEvent()
}

class StartPresenter: StartOutput {
    
    // dependencies
    weak var view: StartInterface?
    var router: Router?
    
    // MARK: - Module -
    
    static func showView(in window: UIWindow?) {
        let startVC = StartViewController()
        
        let presenter = StartPresenter()
        presenter.view = startVC
        presenter.router = DefaultRouter()
        
        startVC.presenter = presenter
        
        presenter.show(in: window)
    }
    
    func show(in window: UIWindow?) {
        guard let viewController = view as? UIViewController else {
            return
        }
        
        let startNC = UINavigationController(rootViewController: viewController)
        startNC.navigationBar.isTranslucent = false
        router?.show(viewConroller: startNC, in: window)
    }
    
    // MARK: - StartScreenOutput -
    
    func didTriggerProductsEvent() {
        showProducts()
    }
    
    func didTriggerCardsEvent() {
        showCards()
    }
    
    // MARK: - Private -
    
    private func showProducts() {
        ProductsPresenter.showView(in: view?.navigationController)
    }
    
    private func showCards() {
        CardsPresenter.showView(in: view?.navigationController)
    }
}
