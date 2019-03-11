//
//  Money Machine
//
//  Created by ryan kowalski on 3/8/19.
//  Copyright © 2019 ryan kowalski. All rights reserved.
//

import UIKit
import Foundation
import CoreData
import RealmSwift


class StoredTransaction: NSManagedObject {
    @NSManaged var coreDataTransaction: Transaction
    @NSManaged var userID: String?
    @NSManaged var date: Date?
    @NSManaged var transactionDescription: String?
//    @NSManaged var transactionAmount: Float?
    @NSManaged var tag: Tags.RawValue?
//    @NSManaged var transactionType: TransactionType?
}

class UserObject: Object {
    var userId: String?
    var userPass: String?
    var totalSavings: Float?
    var totalSpending: Float?
    var transactionArray: [Transaction]?
}

class Transaction: Object {
    var userID: String?
    var date: Date?
    var transactionDescription: String?
    var transactionAmount: Float?
    var tag: Tags?
    var transactionType: TransactionType?
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
}

enum TransactionType {
    case spending, savings
}

