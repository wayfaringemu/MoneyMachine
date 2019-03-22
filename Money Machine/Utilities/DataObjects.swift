//
//  Money Machine
//
//  Created by ryan kowalski on 3/8/19.
//  Copyright © 2019 ryan kowalski. All rights reserved.
//

import UIKit
import Foundation

class UserObject: NSObject {
    var userId: String?
    var userPass: String?
    var totalSavings: Float?
    var totalSpending: Float?
    var transactionArray: [Transaction]?
}

class Transaction {
    var userID: String?
    var date: Date?
    var transactionDescription: String?
    var transactionAmount: Float?
    var tag: String?
    var transactionType: String?
    
    init(dictionary: NSDictionary) {
        userID = dictionary["userID"] as? String
        date = dictionary["date"] as? Date
        transactionDescription = dictionary["transactionDescription"] as? String
        transactionAmount = dictionary["transactionAmount"] as? Float
        tag = dictionary["tag"] as? String
        transactionType = dictionary["transactionType"] as? String
    }
}

// MARK: - Enums

enum Tags: String {
    case Food = "Food"
    case Health = "Health"
    case Home = "Home"
    case Tech = "Tech"
    case Vehicle = "Vehicle"
    case Clothes = "Clothes"
    case Account = "Account"
    case Other = "Other"
    case Savings = "Savings"
}

enum TransactionType: String {
    case spending, savings
}

enum OperationType {
    case adding, subtracting
}
