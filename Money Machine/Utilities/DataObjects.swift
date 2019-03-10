//
//  Money Machine
//
//  Created by ryan kowalski on 3/8/19.
//  Copyright © 2019 ryan kowalski. All rights reserved.
//

import UIKit
import Foundation
import CoreData


class StoredTransaction: NSManagedObject {
    //    @NSManaged var values: [Dictionary<String , Any>]
    @NSManaged var transactionArray: [Transaction]
}

class Transaction: NSObject {
    var userID: String?
    var date: Date?
    var transactionDescription: String?
    var transactionAmount: Float?
    var tag: Tags?
    var transactionType: TransactionType?
}


extension Date {
    func stripTime(currentDate: Date) -> String {
        let dateFormatter:DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString:String = dateFormatter.string(from: currentDate as Date)
        
        return dateString
    }
}

