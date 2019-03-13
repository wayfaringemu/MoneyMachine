//
//  Money_MachineTests.swift
//  Money MachineTests
//
//  Created by ryan kowalski on 3/8/19.
//  Copyright © 2019 ryan kowalski. All rights reserved.
//

import XCTest
@testable import Money_Machine

class MockLoadingViewController: LoadingViewController {
    
    override func setTempArrayData() {
        for transaction in TempItem.transactionArray {
            switch transaction.transactionType {
            case "savings":
                if let amount = transaction.transactionAmount {
                    TempItem.savingsArray.insert(amount, at: 0)
                }
            case "spending":
                if let amount = transaction.transactionAmount {
                    TempItem.spendingArray.insert(amount, at: 0)
                }
            default:
                break
            }
        }
        getTotalExpenditures()
    }
    
    override func  getTotalExpenditures() {
        for amount in TempItem.savingsArray {
            TempItem.savingsTotal += amount
        }
        
        for amount in TempItem.spendingArray {
            TempItem.spendingtotal += amount
        }
        navigateToNextScreen()
    }
    
    override func navigateToNextScreen() {
        let rotation: CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = Double.pi * 2
        rotation.duration = 2.0
        rotation.isCumulative = true
        rotation.repeatCount = Float.greatestFiniteMagnitude

    }
    
}

class Money_MachineTests: XCTestCase {
    let loadingViewController = MockLoadingViewController()
            let dict = ["userID":"william", "date":"date", "transactionDescription":"burger", "transactionAmount":5.55, "transactionType":"savings", "tag":"food" ] as [String : Any] as NSDictionary

    // Test LoadingViewController

    func testLoadingViewController() {
        _ = TempItem()
        _ = UserDefaults.standard
        _ = LoadingViewController()
        loadingViewController.setTempArrayData()
        
        let transaction = Transaction(dictionary: dict)
        var transactionArray = [Transaction]()
        transactionArray.append(transaction)
        var _: Float = 5.55
        var _: Float = 6.67
        for transactionFromArray in transactionArray {
            if let amount = transactionFromArray.transactionAmount {
                XCTAssertEqual(transactionFromArray.userID, "william")
                XCTAssertEqual(transactionFromArray.transactionDescription, "burger")
                XCTAssertEqual(amount, 5.55)
                XCTAssertEqual(transactionFromArray.transactionType, "savings")
                XCTAssertEqual(transactionFromArray.tag, "food")
            }
        }
        let spending = TempItem.spendingArray[0]
        let savings = TempItem.spendingArray[0]
        XCTAssertEqual(spending, 23)
        XCTAssertEqual(savings, 23)
        XCTAssertEqual(TempItem.savingsTotal, 176)
        XCTAssertEqual(TempItem.spendingtotal, 361.380005)
    }
    
    // Test LandingViewController

    func testLandingViewController() {
        let landingViewController = LandingViewController()
        let transaction = Transaction(dictionary: dict)
        var transactionArray = [Transaction]()
        transactionArray.append(transaction)
        
    }
    

}
