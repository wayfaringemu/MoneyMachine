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
    
//    let currentUser = Constants.usersArray[Constants.userIndexValue] as UserObject
    
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
        //temporary.... make dynamic
//        if let savings = TempItem.savingsTotal {
//            savingsValueLabel.text = "$\(savings)"
//        } else {
            savingsValueLabel.text = "$\(String(describing: TempItem.savingsTotal))"
//        }
//        savingsValueLabel.text = "$\(currentUser.totalSavings)"
        savingsAddButton.setTitle("Add Funds", for: .normal)
        
        
        // Spending
        spendingHeaderLabel.text = "Spending"
        spendingHeaderLabel.font = UIFont.boldSystemFont(ofSize: 28)
        //temporary.... make dynamic
        
//        if let spending = TempItem.spendingtotal {
//            spendingValueLabel.text = "$\(spending)"
//        } else {
            spendingValueLabel.text = "$\(String(describing: TempItem.spendingtotal))"
//        }
        spendingAddButton.setTitle("Add Spending", for: .normal)

        
        // Reporting
        reportingImageView.image = UIImage.init(named: "reportIcon")
        reportingLabel.text = "Reporting"
        reportingLabel.font = UIFont.boldSystemFont(ofSize: 24)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.reportingImageTapped(gesture:)))
        reportingImageView.addGestureRecognizer(tapGesture)
        reportingImageView.isUserInteractionEnabled = true
    }

    
    // MARK: - Navigation
    
    
    // MARK: - Actions

    
    @objc func reportingImageTapped(gesture: UIGestureRecognizer) {
        print("go to ReportsController")
        navigateToNextViewController(nextView: "ReportingViewController")
    }
    
    @IBAction func searchButtonTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func savingaAddButtonTapped(_ sender: UIButton) {
        Constants.transactionType = .savings
    }
    
    @IBAction func spendingAddButtonTapped(_ sender: UIButton) {
        Constants.transactionType = .spending
    }
   
    
}
