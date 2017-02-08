//
//  CardsService.swift
//  PaymentDemo
//
//  Created by Evgeniy Leychenko on 06.02.17.
//  Copyright © 2017 theappsolutions.com. All rights reserved.
//

import UIKit

protocol CardsService {
    
    func fetchCards(completion: ArrayErrorCompletion?)
    func addCard(from request: AddCardRequestModel, completion: ObjectErrorCompletion?)
    func deleteCard(cardID: String, completion: ArrayErrorCompletion?)
}

class DefaultCardsService: CardsService {
    
    private var apiManager: Networking
    
    // MARK: - Lifecycle -
    
    init(withApiManager manager: Networking) {
        apiManager = manager
    }
    
    // MARK: - Public -
    
    func fetchCards(completion: ArrayErrorCompletion?) {
        let cardsListRequest = CardsListRequest(token: Defaults.deviceID)
        apiManager.performRequest(request: cardsListRequest, usingValidator: nil, success: { [weak self] (json) in
            self?.parseCards(from: json, completion: completion)
        }) { (error) in
            completion?([], error)
        }
    }
    
    func addCard(from request: AddCardRequestModel, completion: ObjectErrorCompletion?) {
        let addCardRequest = AddCardRequest(token: Defaults.deviceID, cardRequest: request)
        apiManager.performRequest(request: addCardRequest, usingValidator: nil, success: { (json) in
            guard let cardInfo = json["card"] as? [String: Any] else {
                completion?(nil, ResponseError.unknown)
                return
            }
            
            completion?(Card(JSON: cardInfo), nil)
        }) { (error) in
            completion?(nil, error)
        }
    }
    
    func deleteCard(cardID: String, completion: ArrayErrorCompletion?) {
        let deleteCardRequest = DeleteCardRequest(token: Defaults.deviceID, cardID: cardID)
        apiManager.performRequest(request: deleteCardRequest, usingValidator: nil, success: { [weak self] (json) in
            self?.parseCards(from: json, completion: completion)
        }) { (error) in
            completion?([], error)
        }
    }
    
    // MARK: - Private -
    
    private func parseCards(from json: AnyObject, completion: ArrayErrorCompletion?) {
        guard let cardsInfo = json["cards"] as? [[String: Any]] else {
            completion?([], ResponseError.unknown)
            return
        }
        
        let cards = cardsInfo.flatMap({ Card(JSON: $0) })
        completion?(cards, nil)
    }
}
