//
//  LoadingViewController.swift
//  Money Machine
//
//  Created by ryan kowalski on 3/8/19.
//  Copyright © 2019 ryan kowalski. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift

class LoadingViewController: MoneyMachineViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var loadingScreenImageView: UIImageView!
    @IBOutlet weak var loadingScreenLabel: UILabel!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    var searchResults = try! Realm().objects(UserObject.self)
    var searchController: UISearchController!
    var users = try! Realm().objects(UserObject.self).sorted(byKeyPath: "userId", ascending: true)
 
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        loadingScreenImageView.image = UIImage.init(named: "moneyMachineCoin")
        loadingScreenLabel.text = "Money Machine"
        loadingScreenLabel.font = UIFont.boldSystemFont(ofSize: 32)
    }
    
    
    func setTempArrayData() {
        for transaction in TempItem.transactionArray {
            switch transaction.transactionType {
            case .savings?:
                if let amount = transaction.transactionAmount {
                TempItem.savingsArray.insert(amount, at: 0)
                }
            case .spending?:
                if let amount = transaction.transactionAmount {
                    TempItem.spendingArray.insert(amount, at: 0)
                }
            case .none:
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
            retreiveData()
            setTempArrayData()
        } else {
            showAlert(alertTitle: Constants.loginAlertTitle, alertMessage: Constants.loginAlertMessage)
        }
    }
}
