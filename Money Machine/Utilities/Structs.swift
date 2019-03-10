//
//  Structs.swift
//  Money Machine
//
//  Created by ryan kowalski on 3/8/19.
//  Copyright © 2019 ryan kowalski. All rights reserved.
//

import Foundation
import UIKit

struct Constants {
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    static var transactionType = TransactionType.savings
    static var expensesArray = [Transaction]()
    static let spendingAlertMessage = "Please make sure to fill in all fields and select the appropriate Category."
    static let savingsAlertMessage = "Please make sure to fill in all fields"
    static let alertTitle = "Missing Fields"
    static let tagArray = [Tags.Food, Tags.Health, Tags.Home, Tags.Tech, Tags.Vehicle, Tags.Clothes, Tags.Account, Tags.Other, ]
}

struct UserInfo {
    var userId = ""
    var spendingMoney: Float = 300.00
    var savingsMoney: Float = 500.00
}

