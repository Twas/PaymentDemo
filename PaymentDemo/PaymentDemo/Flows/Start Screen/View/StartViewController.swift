//
//  StartViewController.swift
//  PaymentDemo
//
//  Created by Evgeniy Leychenko on 03.02.17.
//  Copyright © 2017 theappsolutions.com. All rights reserved.
//

import UIKit

class StartViewController: UIViewController, StartInterface {
    
    // dependencies
    var presenter: StartOutput?
    
    @IBOutlet weak private var productsButton: UIButton!
    @IBOutlet weak private var cardsButton: UIButton!
    
    // MARK: - Lifecycle -

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = true
    }
    
    // MARK: - Actions -
    
    @IBAction func productsAction(_ sender: UIButton) {
        presenter?.didTriggerProductsEvent()
    }
    
    @IBAction func cardsAction(_ sender: UIButton) {
        presenter?.didTriggerCardsEvent()
    }
    
    // MARK: - Private -
    
    private func setupUI() {
        productsButton.makeRoundedCorners(with: Defaults.buttonCornerRadius)
        cardsButton.makeRoundedCorners(with: Defaults.buttonCornerRadius)
    }
}
