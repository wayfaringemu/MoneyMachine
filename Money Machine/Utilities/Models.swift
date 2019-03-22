//
//  Models.swift
//  Money Machine
//
//  Created by ryan kowalski on 3/17/19.
//  Copyright © 2019 ryan kowalski. All rights reserved.
//

import UIKit

class Models: MoneyMachineViewController {
    
    func addToArrayAndDefaults(valueString: String, descriptionString: String, selectedButton: Int) -> String {
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
                updateTotalExpenditures(savings: nil, spending: value, operation: .subtracting)
                headerText = String(format: "%.2f", TempItem.spendingtotal)
                transactionType = "spending"
            } else {
                tag = "Savings"
                TempItem.savingsArray.insert(value, at: 0)
                updateTotalExpenditures(savings: value, spending: nil, operation: .adding)
                headerText = String(format: "%.2f", TempItem.savingsTotal)
                transactionType = "savings"
            }
            let dict = ["userID":userID, "date":date, "transactionDescription":transactionDescription, "transactionAmount":transactionAmount, "transactionType":transactionType, "tag":tag ] as [String : Any] as NSDictionary
            
            // Store in Defaults
            TempItem.storedArray.append(dict as! [String : Any])
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
    
    
    func removeFromArrayAndDefaults(indexPathRow: Int) {
        let transaction = TempItem.transactionArray[indexPathRow]
        
        TempItem.storedArray.remove(at: indexPathRow)
        TempItem.transactionArray.removeAll()
        for tempDict in TempItem.storedArray {
        let transaction = Transaction(dictionary: tempDict as NSDictionary)
        TempItem.transactionArray.append(transaction)
        }
        
        // empty all values from defaults
        var storedCount = defaults.integer(forKey: "count")
        var index = 0
        for _ in 0...storedCount {
            if let _ = defaults.object(forKey: "\(index)") as? [String : Any] as NSDictionary? {
                defaults.removeObject(forKey: String(index))
            }
            index += 1
        }
        
        // enter all values into defaults again
        storedCount = TempItem.transactionArray.count
        defaults.set(storedCount, forKey: "count")
        for (index,dict) in TempItem.storedArray.enumerated() {
            defaults.set(dict, forKey: String(index))
        }
        
        // remove from spending/savings total

        switch  transaction.transactionType {
        case "savings":
            updateTotalExpenditures(savings: transaction.transactionAmount, spending: nil, operation: .adding)
        case "spending":
            updateTotalExpenditures(savings: nil, spending: transaction.transactionAmount, operation: .subtracting)
        default:
            break
        }
    }
    
    func  updateTotalExpenditures(savings: Float?, spending: Float?, operation: OperationType) {
        if let savingsAmt = savings {
            if operation == .adding {
                TempItem.savingsTotal += savingsAmt
            } else {
                TempItem.savingsTotal -= savingsAmt
            }
        }
        if let spendingAmt = spending {
            if operation == .adding {
                TempItem.spendingtotal += spendingAmt
            } else {
                TempItem.spendingtotal -= spendingAmt
                
            }
        }
    }
    
}
