//
//  AddProductViewController.swift
//  PaymentDemo
//
//  Created by Evgeniy Leychenko on 08.02.17.
//  Copyright © 2017 theappsolutions.com. All rights reserved.
//

import UIKit

class AddProductViewController: UIViewController, AddProductInterface, ResponderSwitchable {
    
    // dependencies
    var presenter: AddProductOutput?
    
    var productTitle: String { return titleField.text ?? "" }
    var productDescription: String { return descriptionField.text ?? "" }
    var productAmount: String { return amountField.text ?? "" }
    
    var responders: [UIResponder]? { return [titleField, descriptionField, amountField] }
    
    @IBOutlet weak private var titleField: UITextField!
    @IBOutlet weak private var descriptionField: UITextField!
    @IBOutlet weak private var amountField: UITextField!
    @IBOutlet weak private var addButton: UIButton!
    
    // MARK: - Lifecycle -

    override func viewDidLoad() {
        super.viewDidLoad()

        performInitialSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = false
    }

    // MARK: - Actions -
    
    @IBAction func addAction(_ sender: UIButton) {
        presenter?.didTriggerAddProductEvent()
    }
    
    // MARK: - Private -
    
    private func performInitialSetup() {
        edgesForExtendedLayout = UIRectEdge(rawValue: 0)
        view.enableResignEditingOnTap()
        
        addButton.makeRoundedCorners(with: Defaults.buttonCornerRadius)
    }
}

extension AddProductViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if !switchToNextResponder() {
            presenter?.didTriggerAddProductEvent()
        }
        
        return false
    }
}
