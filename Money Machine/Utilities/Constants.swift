//
//  Constants.swift
//  Money Machine
//
//  Created by ryan kowalski on 3/8/19.
//  Copyright © 2019 ryan kowalski. All rights reserved.
//
import UIKit
import Foundation

struct Constants {
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    static var transactionType = TransactionType.savings
    
    static let spendingAlertMessage = "Please make sure to fill in all fields and select the appropriate Category."
    static let savingsAlertMessage = "Please make sure to fill in all fields"
    static let savingsSpendingAlertTitle = "Missing Field"
    static let loginAlertTitle = "Login Error"
    static let loginAlertMessage = "Please make sure Username is filled in."
    static let searchPlaceHolderText = "search by transaction, user, or date"
    
    
    static let tagArray = [Tags.Food, Tags.Health, Tags.Home, Tags.Tech, Tags.Vehicle, Tags.Clothes, Tags.Account, Tags.Other, ]
}

struct TempItem {
    static var user = ""
    static var savingsArray = [Float]()
    static var spendingArray = [Float]()
    static var transactionArray = [Transaction]()
    static var savingsTotal: Float = 0.00
    static var spendingtotal: Float = 0.00
    static var storedArray = Array<[String:Any]>()
    static var searchArray = [Transaction]()
}





