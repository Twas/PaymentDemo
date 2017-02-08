//
//  CardsViewController.swift
//  PaymentDemo
//
//  Created by Evgeniy Leychenko on 06.02.17.
//  Copyright © 2017 theappsolutions.com. All rights reserved.
//

import UIKit

class CardsViewController: UIViewController, CardsInterface {

    // dependencies
    var presenter: CardsOutput?
    
    var fullscreenView: UIView? { return self.view.window }
    
    @IBOutlet weak private var tableView: UITableView!
    
    private var addButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle(Localization.Buttons.add, for: .normal)
        button.setTitleColor(UIColor.blue, for: .normal)
        button.sizeToFit()
        
        return button
    }()
    
    private var dataDisplayManager = CardsListDataDisplayManager()
    
    // MARK: - Lifecycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        performInialSetup()
        
        presenter?.viewIsReady()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = false
    }
    
    // MARK: - Actions -
    
    func addAction(_ sender: UIButton) {
        presenter?.didTriggerAddCardEvent()
    }
    
    // MARK: - Cards Interface -
    
    func reload(cards: [Card]) {
        dataDisplayManager.reload(with: cards)
    }
    
    func askUserForDeletion(_ card: Card, result: @escaping (Bool) -> Void) {
        let deletionAlert = UIAlertController(title: "", message: Localization.Alerts.deleteCardMessage, preferredStyle: .alert)
        
        deletionAlert.addAction(UIAlertAction(title: Localization.Buttons.yes, style: .default, handler: { (_) in
            result(true)
        }))
        deletionAlert.addAction(UIAlertAction(title: Localization.Buttons.no, style: .cancel, handler: { (_) in
            result(false)
        }))
        
        present(deletionAlert, animated: true, completion: nil)
    }
    
    // MARK: - Private -
    
    private func performInialSetup() {
        addAddButton()
        
        dataDisplayManager.registerCells(for: tableView)
        dataDisplayManager.delegate = self
    }
    
    private func addAddButton() {
        addButton.addTarget(self, action: #selector(addAction(_:)), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: addButton)
    }
}

extension CardsViewController: CardsListDataDisplayManagerDelegate {
    
    func delete(card: Card) {
        presenter?.didTriggerDeleteCardEvent(card)
    }
    
    func select(card: Card) {
        presenter?.didSelectCard(card)
    }
}
