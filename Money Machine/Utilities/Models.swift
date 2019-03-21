//
//  Models.swift
//  Money Machine
//
//  Created by ryan kowalski on 3/17/19.
//  Copyright © 2019 ryan kowalski. All rights reserved.
//

import UIKit

class Models: MoneyMachineViewController {
    
    func setArray(valueString: String, descriptionString: String, selectedButton: Int) -> String {
        var headerText = ""

        if let value = Float(valueString) {
            let userID = TempItem.user
            let date = Date()
            let transactionDescription = descriptionString
            let transactionAmount = value
            var transactionType = ""
            var tag = ""
            if Constants.transactionType == .spending {
                tag = Constants.tagArray[selectedButton].rawValue
                TempItem.spendingArray.insert(value, at: 0)
                updateTotalExpenditures(savings: nil, spending: value)
                headerText = String(format: "%.2f", TempItem.spendingtotal)
                transactionType = "spending"
            } else {
                tag = "Savings"
                TempItem.savingsArray.insert(value, at: 0)
                updateTotalExpenditures(savings: value, spending: nil)
                headerText = String(format: "%.2f", TempItem.savingsTotal)
                transactionType = "savings"
            }
            let dict = ["userID":userID, "date":date, "transactionDescription":transactionDescription, "transactionAmount":transactionAmount, "transactionType":transactionType, "tag":tag ] as [String : Any] as NSDictionary
            
            // Store in Defaults
            
            let storedItemCount = defaults.integer(forKey: "count")
            let count = storedItemCount + 1
            defaults.set(count, forKey: "count")
            
            defaults.set(dict, forKey: String(count))
            
            //Set as Object
            let transaction = Transaction(dictionary: dict)
            TempItem.transactionArray.insert(transaction, at: 0)
            
        }
        return headerText
    }
    
    func  updateTotalExpenditures(savings: Float?, spending:Float?) {
        if let savingsAmt = savings {
            TempItem.savingsTotal += savingsAmt
        }
        if let spendingAmt = spending {
            TempItem.spendingtotal += spendingAmt
        }
    }
    
    
}
