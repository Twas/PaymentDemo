//
//  CardTableViewCell.swift
//  PaymentDemo
//
//  Created by Evgeniy Leychenko on 06.02.17.
//  Copyright © 2017 theappsolutions.com. All rights reserved.
//

import UIKit

class CardTableViewCell: UITableViewCell {
    
    var longPressHandler: Event?
    
    @IBOutlet weak private var cardBrandImageView: UIImageView!
    @IBOutlet weak private var cardNumberLabel: UILabel!
    
    // MARK: - Lifecycle -

    override func awakeFromNib() {
        super.awakeFromNib()

        addLongPressRecognizer()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        cardBrandImageView.image = nil
        cardNumberLabel.text = ""
    }
    
    // MARK: - Actions -
    
    @IBAction func longPressAction(_ sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            longPressHandler?()
        }
    }

    // MARK: - Public -
    
    func setup(with card: Card) {
        cardNumberLabel.text = "...\(card.cardNumber)"
        cardBrandImageView.image = card.brand?.imageRepresentation()
    }
    
    // MARK: - Private -
    
    private func addLongPressRecognizer() {
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPressAction(_:)))
        addGestureRecognizer(longPressRecognizer)
    }
}

extension CardTableViewCell: ReusableCell {
    
    static var cellID: String { return String(describing: self) }
    static var height: CGFloat? { return nil }
    
    func setup(with object: Any) {
        guard let card = object as? Card else {
            return
        }
        
        setup(with: card)
    }
}
