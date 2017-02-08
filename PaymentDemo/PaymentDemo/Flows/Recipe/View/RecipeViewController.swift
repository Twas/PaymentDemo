//
//  RecipeViewController.swift
//  PaymentDemo
//
//  Created by Evgeniy Leychenko on 08.02.17.
//  Copyright © 2017 theappsolutions.com. All rights reserved.
//

import UIKit

class RecipeViewController: UIViewController, RecipeInterface {
    
    // dependencies
    var presenter: RecipeOutput?
    
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var cardBrandImageView: UIImageView!
    @IBOutlet weak var cardNubmerLabel: UILabel!
    @IBOutlet weak var purchaseButton: UIButton!
    
    // MARK: - Lifecycle -

    override func viewDidLoad() {
        super.viewDidLoad()

        performInitialSetup()
        presenter?.viewIsReady()
    }
    
    // MARK: - Actions -
    
    @IBAction func purchaseAction(_ sender: UIButton) {
        presenter?.didTriggerPurchaseEvent()
    }
    
    // MARK: - RecipeInterface -
    
    func set(productTitle: String?) {
        productNameLabel.text = productTitle
    }
    
    func set(productPrice: String?) {
        productPriceLabel.text = productPrice
    }
    
    func set(cardBrandImage: UIImage?) {
        cardBrandImageView.image = cardBrandImage
    }
    
    func set(cardNumber: String?) {
        cardNubmerLabel.text = "...\(cardNumber ?? "")"
    }
    
    // MARK: - Private -
    
    func performInitialSetup() {
        purchaseButton.makeRoundedCorners(with: Defaults.buttonCornerRadius)
    }
}
