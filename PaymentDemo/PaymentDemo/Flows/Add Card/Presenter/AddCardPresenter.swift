//
//  AddCardPresenter.swift
//  PaymentDemo
//
//  Created by Evgeniy Leychenko on 06.02.17.
//  Copyright © 2017 theappsolutions.com. All rights reserved.
//

import UIKit

protocol AddCardInterface: class, DisplayingUserActivity, DisplayingError {
    
    var cardNumber: String { get }
    var cardCVC: String { get }
    var cardExpirationMonth: String { get }
    var cardExpirationYear: String { get }
    
    func performAppearAnimation(on containingView: UIView?)
    func performHideAnimation()
}

protocol AddCardOutput {
    
    func didTriggerAddCardEvent()
    func didTriggerBackgroundTapEvent()
}

class AddCardPresenter: AddCardOutput {
    
    // dependecies
    weak var view: AddCardInterface?
    var cardsService: CardsService?
    
    private var successfulCompletionHandler: Event?
    
    // MARK: - Module -
    
    static func showView(in containingView: UIView?, successHandler: Event?) {
        guard let views = Bundle.main.loadNibNamed(String(describing: AddCardView.self), owner: nil, options: nil),
            let addCardView = views.first as? AddCardView else {
            return
        }
        
        let presenter = AddCardPresenter()
        presenter.view = addCardView
        presenter.cardsService = Services.cardsServise()
        presenter.successfulCompletionHandler = successHandler
        
        addCardView.presenter = presenter
        
        presenter.show(in: containingView)
    }
    
    func show(in containingView: UIView?) {
        guard let containingView = containingView else {
            return
        }
        
        view?.performAppearAnimation(on: containingView)
    }
    
    // MARK: - AddCardOutput -
    
    func didTriggerAddCardEvent() {
        guard let view = view else {
            return
        }
        
        view.showActivity()
        let cardRequest = AddCardRequestModel(number: view.cardNumber,
                                              cvc: view.cardCVC,
                                              expirationMonth: view.cardExpirationMonth,
                                              expirationYear: view.cardExpirationYear)
        cardsService?.addCard(from: cardRequest, completion: { (card, error) in
            if card != nil {
                view.hideActivity()
                view.performHideAnimation()
                self.successfulCompletionHandler?()
            } else if let error = error {
                view.displayError(error.messages)
            } else {
                view.hideActivity()
            }
        })
    }
    
    func didTriggerBackgroundTapEvent() {
        view?.performHideAnimation()
    }
}
