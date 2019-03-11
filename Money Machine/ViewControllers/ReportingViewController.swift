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
    @IBOutlet weak var searchTextView: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Variables
    let userObject = UserObject()
    
    override func viewWillAppear(_ animated: Bool) {
        setupView()
    }
    
    func setupView() {
        reportingMainUIView.backgroundColor = .clear; searchUIView.backgroundColor = .clear
        searchTextView.placeholder = Constants.searchPlaceHolderText
        backButton.setTitle("Back", for: .normal)
        
    }
    
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - TableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TempItem.transactionArray.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell") else {
                return UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: "UITableViewCell")
            }
            return cell
        }()
        
        let array = TempItem.transactionArray
        if let date = array[indexPath.row].date,
            let user = array[indexPath.row].userID,
            let transactionDescription = array[indexPath.row].transactionDescription,
            let amount = array[indexPath.row].transactionAmount {
            let amountString = String(describing: amount)
            cell.textLabel?.adjustsFontSizeToFitWidth = true
            cell.detailTextLabel?.adjustsFontSizeToFitWidth = true
            
            cell.textLabel?.text       = "\(date.stripTime(currentDate: date))  \(user)   \(transactionDescription)"
            
            if let tagType = array[indexPath.row].tag {
                cell.detailTextLabel?.text = "\(tagType.rawValue)    $\(amountString)"
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

