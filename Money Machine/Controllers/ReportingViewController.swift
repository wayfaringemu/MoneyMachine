//
//  ReportingViewController.swift
//  Money Machine
//
//  Created by ryan kowalski on 3/9/19.
//  Copyright © 2019 ryan kowalski. All rights reserved.
//

import UIKit

class ReportingViewController: MoneyMachineViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Outlets
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var reportingMainUIView: RoundShadowView!
    @IBOutlet weak var searchUIView: RoundShadowView!
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Variables
    var classPurporse = "Report"
    var contextualArray = TempItem.transactionArray
    
    override func viewWillAppear(_ animated: Bool) {
        setupView()
    }
    
    func setupView() {
        reportingMainUIView.backgroundColor = .clear
        backButton.setTitle("Back", for: .normal)
        self.title = classPurporse
    }
    
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - TableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contextualArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionTableViewCell") as? TransactionTableViewCell {
            var tagString = ""
            var amountString = ""
            var userString = ""
            var descriptionString = ""
            var dateString = ""
            let transactionString = Constants.transactionType.rawValue
            
            let array = TempItem.transactionArray
            if let date = array[indexPath.row].date,
                let transactionDescription = array[indexPath.row].transactionDescription,
                let amount = array[indexPath.row].transactionAmount,
                let user = array[indexPath.row].userID {
                
                amountString = String(format: "%.2f", amount)
                dateString = date.stripTime(currentDate: date)
                userString = user
                descriptionString = transactionDescription
                
                if let tagType = array[indexPath.row].tag {
                    tagString = tagType
                }
            }
            
            cell.setupCell(date: dateString, user: userString, description: descriptionString, value: amountString, tag: tagString, transactionType: transactionString)
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    // Adding swipe to delete:
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            // handle delete (by removing the data from your array and updating the tableview)
        }
    }
    
}

