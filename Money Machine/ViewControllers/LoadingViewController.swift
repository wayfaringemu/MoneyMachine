//
//  LoadingViewController.swift
//  Money Machine
//
//  Created by ryan kowalski on 3/8/19.
//  Copyright © 2019 ryan kowalski. All rights reserved.
//

import UIKit
import CoreData

class LoadingViewController: MoneyMachineViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var loadingScreenImageView: UIImageView!
    @IBOutlet weak var loadingScreenLabel: UILabel!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        let storedCount = defaults.integer(forKey: "count")
        for i in 1...storedCount {
            if let dict = defaults.dictionary(forKey: String(i)) {
                let transaction = Transaction(dictionary: dict as NSDictionary)
                TempItem.transactionArray.append(transaction)
            }
        }
    }
    
    func setupView() {
        loadingScreenImageView.image = UIImage.init(named: "moneyMachineCoin")
        loadingScreenLabel.text = "Money Machine"
        loadingScreenLabel.font = UIFont.boldSystemFont(ofSize: 32)
    }
    
    
    func setTempArrayData() {
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
    
    func  getTotalExpenditures() {
        for amount in TempItem.savingsArray {
            TempItem.savingsTotal += amount
        }
        
        for amount in TempItem.spendingArray {
            TempItem.spendingtotal += amount
        }
        navigateToNextScreen()
    }
    
    
    // MARK: - Navigation
    
    func navigateToNextScreen() {
        let rotation: CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = Double.pi * 2
        rotation.duration = 2.0
        rotation.isCumulative = true
        rotation.repeatCount = Float.greatestFiniteMagnitude
        loadingScreenImageView.layer.add(rotation, forKey: "rotationAnimation")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
            self.navigateToNextViewController(nextView: "LandingViewController")
        }
    }
    
    // MARK: - Actions
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        if let userText = usernameTextField.text, userText.count > 0 {
            TempItem.user = userText
            setTempArrayData()
        } else {
            showAlert(alertTitle: Constants.loginAlertTitle, alertMessage: Constants.loginAlertMessage)
        }
    }
}
