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
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    var searchResults = try! Realm().objects(UserObject.self)
    var searchController: UISearchController!
    var users = try! Realm().objects(UserObject.self).sorted(byKeyPath: "userId", ascending: true)
    let userObject = UserObject()


    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
    }
    
    func setupView() {
        loadingScreenImageView.image = UIImage.init(named: "moneyMachineCoin")
        loadingScreenLabel.text = "Money Machine"
        loadingScreenLabel.font = UIFont.boldSystemFont(ofSize: 32)
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        if let userText = usernameTextField.text, let passText = passwordTextField.text, userText.count > 0 && passText.count > 0 {

            
            var userExists = false
            for (index, user) in users.enumerated() {
                if user.userId == userText {
                    userExists = true
                    self.userObject.userId = user.userId
                    Constants.userIndexValue = index
                }
            }
            if userExists != true {
                let userObject = UserObject()
                userObject.userId = userText
                userObject.userPass = passText
                userObject.totalSavings = 0.00
                userObject.totalSpending = 0.00

                Constants.usersArray.insert(userObject, at: 0)
                
            } else {
                //retreive user data
//                if let storedUsername = userObject?.userId,
//                    let storedPass = userObject?.userPass,
//                    let storedSavings = userObject?.totalSavings,
//                    let storedSpending = userObject?.totalSpending,
//                    let storedArray = userObject?.transactionArray {
//                    var userInfo = UserInfo()
//                    UserInfo.userId = storedUsername
//                        UserInfo.userPass = storedPass
//                    UserInfo.savingsMoney = storedSavings
//                    UserInfo.spendingMoney = storedSpending
//                    UserInfo().transactionArray = storedArray
//                }
            }
            
            let rotation: CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
            rotation.toValue = Double.pi * 2
            rotation.duration = 2.0
            rotation.isCumulative = true
            rotation.repeatCount = Float.greatestFiniteMagnitude
            loadingScreenImageView.layer.add(rotation, forKey: "rotationAnimation")
            
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                self.navigateToNextViewController(nextView: "LandingViewController")
            }
        } else {
            showAlert(alertTitle: Constants.loginAlertTitle, alertMessage: Constants.loginAlertMessage)
        }
    }

    
}
