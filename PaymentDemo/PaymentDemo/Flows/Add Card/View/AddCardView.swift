//
//  AddCardView.swift
//  PaymentDemo
//
//  Created by Evgeniy Leychenko on 06.02.17.
//  Copyright © 2017 theappsolutions.com. All rights reserved.
//

import UIKit
import CoreGraphics

class AddCardView: UIView, AddCardInterface {
    
    // dependencies
    var presenter: AddCardOutput?
    
    var cardNumber: String { return cardNumberField.text ?? "" }
    var cardCVC: String { return cvvField.text ?? "" }
    var cardExpirationMonth: String { return expMonthField.text ?? "" }
    var cardExpirationYear: String { return expYearField.text ?? "" }
    
    @IBOutlet weak private var containerView: UIView!
    @IBOutlet weak private var cardNumberField: UITextField!
    @IBOutlet weak private var cvvField: UITextField!
    @IBOutlet weak private var expMonthField: UITextField!
    @IBOutlet weak private var addCardButton: UIButton!
    @IBOutlet weak private var expYearField: UITextField!
    
    // MARK: - Lifecyctle -
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }
    
    // MARK: - Actions -
    
    @IBAction func addCardAction(_ sender: UIButton) {
        presenter?.didTriggerAddCardEvent()
    }
    
    @IBAction func backgroundTappedAction(_ sender: UITapGestureRecognizer) {
        presenter?.didTriggerBackgroundTapEvent()
    }
    
    // MARK: - AddCardInterface -
    
    func performAppearAnimation(on containingView: UIView?) {
        guard let containingView = containingView else {
            return
        }
        
        containingView.addSubview(self)
        
        alpha = 0.0
        containerView.transform = CGAffineTransform(scaleX: 0, y: 0)
        
        UIView.animate(withDuration: 1,
                       delay: 0.25,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 5,
                       options: .curveEaseInOut,
                       animations: {
                        self.alpha = 1.0
                        self.containerView.transform = CGAffineTransform.identity
        })
    }
    
    func performHideAnimation() {
        guard let superview = superview else {
            return
        }
        
        UIView.animate(withDuration: Defaults.animationDuration, animations: { 
            self.containerView.frame.origin.y = superview.frame.maxY
        }) { (finished) in
            self.removeFromSuperview()
        }
    }
    
    // MARK: - Private -
    
    private func setupUI() {
        containerView.makeRoundedCorners(with: Defaults.buttonCornerRadius)
        addCardButton.makeRoundedCorners(with: Defaults.buttonCornerRadius)
    }
}

extension AddCardView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
