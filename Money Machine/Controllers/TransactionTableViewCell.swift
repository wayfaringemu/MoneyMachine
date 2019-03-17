//
//  TransactionTableViewCell.swift
//  Money Machine
//
//  Created by ryan kowalski on 3/17/19.
//  Copyright © 2019 ryan kowalski. All rights reserved.
//

import UIKit

class TransactionTableViewCell: UITableViewCell {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var tagLabel: UILabel!
    
    func setupCell(date: String?, user: String?, description: String?, value: String?, tag: String, transactionType: String) {
        dateLabel.adjustsFontSizeToFitWidth = true; dateLabel.adjustsFontSizeToFitWidth = true
        descriptionLabel.adjustsFontSizeToFitWidth = true; descriptionLabel.adjustsFontSizeToFitWidth = true
        userLabel.adjustsFontSizeToFitWidth = true; userLabel.adjustsFontSizeToFitWidth = true
        valueLabel.adjustsFontSizeToFitWidth = true; valueLabel.adjustsFontSizeToFitWidth = true

        userLabel.font = UIFont.boldSystemFont(ofSize: 17)
        
        if tag == "Savings" {
            valueLabel.textColor = .black
            tagLabel.text = ""

        } else {
            valueLabel.textColor = .red
            tagLabel.text = tag
        }
        dateLabel.text = date
        descriptionLabel.text = description
        userLabel.text = user
        valueLabel.text = value
    }
    
}
