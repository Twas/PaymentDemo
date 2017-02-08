//
//  CardsPresenter.swift
//  PaymentDemo
//
//  Created by Evgeniy Leychenko on 06.02.17.
//  Copyright © 2017 theappsolutions.com. All rights reserved.
//

import UIKit

protocol CardsInterface: Navigatable, DisplayingUserActivity, DisplayingError {
    
    var fullscreenView: UIView? { get }
    
    func reload(cards: [Card])
    func askUserForDeletion(_ card: Card, result: @escaping (Bool) -> Void)
}

protocol CardsOutput {
    
    func viewIsReady()
    
    func didTriggerAddCardEvent()
    func didTriggerDeleteCardEvent(_ card: Card)
    func didSelectCard(_ card: Card)
}

class CardsPresenter: CardsOutput {
    
    // dependencies
    weak var view: CardsInterface?
    var router: Router?
    var cardsService: CardsService?
    var cart: Cart?
    
    private var cards: [Card] = []
    
    // MARK: - Module -
    
    static func showView(in navigationController: UINavigationController?, using cart: Cart? = nil) {
        let cardsVC = CardsViewController()
        
        let presenter = CardsPresenter()
        presenter.view = cardsVC
        presenter.router = DefaultRouter()
        presenter.cardsService = Services.cardsServise()
        presenter.cart = cart
        
        cardsVC.presenter = presenter
        
        presenter.show(in: navigationController)
    }

    func show(in navigationController: UINavigationController?) {
        guard let viewController = view as? UIViewController else {
            return
        }
        
        router?.show(viewController: viewController, in: navigationController, animated: true)
    }
    
    // MARK: - Cards Output -
    
    func viewIsReady() {
        updateCardsList()
    }
    
    func didTriggerAddCardEvent() {
        AddCardPresenter.showView(in: view?.fullscreenView, successHandler: cardSuccessfullyAddedEvent)
    }
    
    func didTriggerDeleteCardEvent(_ card: Card) {
        view?.askUserForDeletion(card, result: { (agreed) in
            if agreed {
                self.deleteCard(card)
            }
        })
    }
    
    func didSelectCard(_ card: Card) {
        guard let cart = cart else {
            return
        }
        
        cart.card = card
        RecipePresenter.showView(in: view?.navigationController, using: cart)
    }
    
    // MARL: - Private -
    
    private func updateCardsList() {
        view?.showActivity()
        cardsService?.fetchCards(completion: { [weak self] (cards, error) in
            self?.view?.hideActivity()
            if let cards = cards as? [Card] {
                self?.cards = cards
                self?.reloadView()
            }
        })
    }
    
    private func deleteCard(_ card: Card) {
        view?.showActivity()
        cardsService?.deleteCard(cardID: card.id, completion: { [weak self] (cards, error) in
            self?.view?.hideActivity()
            if let cards = cards as? [Card] {
                self?.cards = cards
                self?.reloadView()
            } else if let error = error {
                self?.view?.displayError(error.messages)
            }
        })
    }
    
    private func reloadView() {
        view?.reload(cards: cards)
    }
    
    private func cardSuccessfullyAddedEvent() {
        updateCardsList()
    }
}

