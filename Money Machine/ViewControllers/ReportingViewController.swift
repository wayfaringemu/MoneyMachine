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
        let cell: UITableViewCell = {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell") else {
                return UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: "UITableViewCell")
            }
            return cell
        }()
        
        let array = contextualArray
        if let date = array[indexPath.row].date,
            let user = array[indexPath.row].userID,
            let transactionDescription = array[indexPath.row].transactionDescription,
            let amount = array[indexPath.row].transactionAmount,
            let type = array[indexPath.row].transactionType {
            let amountString = String(format: "%.2f", amount)
            cell.textLabel?.adjustsFontSizeToFitWidth = true
            cell.detailTextLabel?.adjustsFontSizeToFitWidth = true
            if type == "spending" {
                cell.detailTextLabel?.textColor = .red
            } else {
                cell.detailTextLabel?.textColor = .black

            }
            
            
            cell.textLabel?.text       = "\(date.stripTime(currentDate: date))  \(user)   \(transactionDescription)"
            
            if let tagType = array[indexPath.row].tag {
                cell.detailTextLabel?.text = "\(tagType)    $\(amountString)"
            } else {
                cell.detailTextLabel?.text = "$\(amountString)"
            }
        } else {
            cell.textLabel?.text       = ""
            cell.detailTextLabel?.text = ""
        }
        return cell
    }
    
}

