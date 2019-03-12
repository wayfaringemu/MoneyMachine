//
//  LandingViewController.swift
//  Money Machine
//
//  Created by ryan kowalski on 3/9/19.
//  Copyright © 2019 ryan kowalski. All rights reserved.
//

import UIKit

class LandingViewController: MoneyMachineViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    
    @IBOutlet weak var savingsUIView: RoundShadowView!
    @IBOutlet weak var spendingUIView: RoundShadowView!
    @IBOutlet weak var reportUIView: RoundShadowView!
    @IBOutlet weak var searchUIView: RoundShadowView!
    
    @IBOutlet weak var savingsHeaderLabel: UILabel!
    @IBOutlet weak var savingsValueLabel: UILabel!
    @IBOutlet weak var savingsAddButton: UIButton!
    
    @IBOutlet weak var spendingHeaderLabel: UILabel!
    @IBOutlet weak var spendingValueLabel: UILabel!
    @IBOutlet weak var spendingAddButton: UIButton!
    
    @IBOutlet weak var reportingImageView: UIImageView!
    @IBOutlet weak var reportingLabel: UILabel!
    
    
    // MARK: - Variables
    
    override func viewWillAppear(_ animated: Bool) {
        setupView()
    }
    
    func setupView() {
        savingsUIView.backgroundColor = .clear; spendingUIView.backgroundColor = .clear; reportUIView.backgroundColor = .clear; searchUIView.backgroundColor = .clear
        
        // Search
        searchButton.setTitle("Search", for: .normal)
        searchTextField.placeholder =  Constants.searchPlaceHolderText
        
        // Savings
        savingsHeaderLabel.text = "Savings"
        savingsHeaderLabel.font = UIFont.boldSystemFont(ofSize: 28)
        savingsValueLabel.text = "$\(String(describing: TempItem.savingsTotal))"
        savingsAddButton.setTitle("Add Funds", for: .normal)
        
        // Spending
        spendingHeaderLabel.text = "Spending"
        spendingHeaderLabel.font = UIFont.boldSystemFont(ofSize: 28)
        spendingValueLabel.text = "$\(String(describing: TempItem.spendingtotal))"
        spendingAddButton.setTitle("Add Spending", for: .normal)
        
        // Reporting
        reportingImageView.image = UIImage.init(named: "reportIcon")
        reportingLabel.text = "Reporting"
        reportingLabel.font = UIFont.boldSystemFont(ofSize: 24)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.reportingImageTapped(gesture:)))
        reportingImageView.addGestureRecognizer(tapGesture)
        reportingImageView.isUserInteractionEnabled = true
    }
    
    // MARK: - Actions
    
    
    @objc func reportingImageTapped(gesture: UIGestureRecognizer) {
        navigateToNextViewController(nextView: "ReportingViewController")
    }
    
    @IBAction func searchButtonTapped(_ sender: UIButton) {
        TempItem.searchArray.removeAll()
        if let textToSearch = searchTextField.text {
            for transaction: Transaction in TempItem.transactionArray {
                if let date = transaction.date,
                    let user = transaction.userID,
                    let tag = transaction.tag,
                    let amount = transaction.transactionAmount,
                    let descrip = transaction.transactionDescription,
                    let type = transaction.transactionType {
                    
                    var match = false
                    if let _ = user.range(of: textToSearch, options: .caseInsensitive) {
                        match = true
                    }
                    if let _ = String(date.stripTime(currentDate: date)).range(of: textToSearch, options: .caseInsensitive) {
                        match = true
                        
                    }
                    if let _ = amount.description.range(of: textToSearch, options: .caseInsensitive) {
                        match = true
                        
                    }
                    if let _ = descrip.range(of: textToSearch, options: .caseInsensitive) {
                        match = true
                        
                    }
                    if let _ = type.range(of: textToSearch, options: .caseInsensitive) {
                        match = true
                        
                    }
                    if let _ = tag.range(of: textToSearch, options: .caseInsensitive) {
                        match = true
                    }
                    if match == true {
                        TempItem.searchArray.append(transaction)
                    }
                }
            }
            if TempItem.searchArray.count > 0 {
                if let VC1 = self.storyboard?.instantiateViewController(withIdentifier: "ReportingViewController") as? ReportingViewController  {
                    let navController = UINavigationController(rootViewController: VC1)
                    VC1.classPurporse = "Search"
                    VC1.contextualArray = TempItem.searchArray
                    searchTextField.text = ""
                    self.present(navController, animated:true, completion: nil)
                }
            } else {
                showAlert(alertTitle: "Search Error", alertMessage: "The item you were looking for could not be found")
            }
        }
    }
    
    @IBAction func savingaAddButtonTapped(_ sender: UIButton) {
        Constants.transactionType = .savings
    }
    
    @IBAction func spendingAddButtonTapped(_ sender: UIButton) {
        Constants.transactionType = .spending
    }
}
