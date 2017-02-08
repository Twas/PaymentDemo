//
//  OrderTableViewCell.swift
//  PaymentDemo
//
//  Created by Evgeniy Leychenko on 08.02.17.
//  Copyright © 2017 theappsolutions.com. All rights reserved.
//

import UIKit

class OrderTableViewCell: UITableViewCell {
    
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var descriptionLabel: UILabel!
    @IBOutlet weak private var statusLabel: UILabel!
    @IBOutlet weak private var amountLabel: UILabel!
    @IBOutlet weak private var paymentLabel: UILabel!

    // MARK: - Lifecycle -

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        titleLabel.text = ""
        descriptionLabel.text = ""
        statusLabel.text = ""
        amountLabel.text = ""
        paymentLabel.text = ""
    }
    
    // MARK: - Public -
    
    func setup(with order: Order) {
        titleLabel.text = order.title
        descriptionLabel.text = order.description
        amountLabel.text = order.stringAmount()
        
        statusLabel.text = order.status?.stringRepresentation()
        statusLabel.textColor = order.status?.colorRepresentation()
        
        if let payment = order.payment {
            paymentLabel.text = payment.status?.stringRepresentation()
            paymentLabel.textColor = payment.status?.colorRepresentation()
        } else {
            paymentLabel.text = Localization.Products.paymentUnavailable
            paymentLabel.textColor = UIColor.darkText
        }
    }
}

extension OrderTableViewCell: ReusableCell {
    
    static var cellID: String { return String(describing: self) }
    static var height: CGFloat? { return nil }
    
    func setup(with object: Any) {
        guard let order = object as? Order else {
            return
        }
        
        setup(with: order)
    }
}
