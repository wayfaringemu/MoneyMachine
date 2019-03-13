//
//  AddingSavingSpendingViewController.swift
//  Money Machine
//
//  Created by ryan kowalski on 3/9/19.
//  Copyright © 2019 ryan kowalski. All rights reserved.
//

import UIKit

class AddingSavingSpendingViewController: MoneyMachineViewController, UITableViewDelegate, UITableViewDataSource  {
    
    // MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var mainStackView: UIStackView!
    @IBOutlet weak var headerUiView: RoundShadowView!
    @IBOutlet weak var amountToAddUIView: RoundShadowView!
    @IBOutlet weak var tagUIView: RoundShadowView!
    @IBOutlet weak var tableViewUIView: RoundShadowView!
    @IBOutlet weak var addTransactionUIView: RoundShadowView!
    
    @IBOutlet weak var headerDescriptionLabel: UILabel!
    @IBOutlet weak var headerValueLabel: UILabel!
    
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var valueTextField: UITextField!
    @IBOutlet weak var addValueButton: UIButton!
    @IBOutlet weak var selectTagsLabel: UILabel!
    
    
    @IBOutlet var tagButtonCollection: [UIButton]!
    
    // MARK: - Variables
    
    let buttonTitles = ["Food", "Health", "Home", "Tech", "Vehicle", "Clothes", "Account", "Other"]
    var selectedButton = 9
    var alertMessage = ""
    var valueString = ""
    var descriptionString = ""
    
    
    override func viewWillAppear(_ animated: Bool) {
        setupView()
    }
    
    // MARK: - UI Setup
    
    func setupView() {
        setUpNavBar()
        headerUiView.backgroundColor = .clear; amountToAddUIView.backgroundColor = .clear; tagUIView.backgroundColor = .clear; tableViewUIView.backgroundColor = .clear; addTransactionUIView.backgroundColor = .clear;
        
        descriptionTextField.placeholder = "description"
        valueTextField.placeholder = "$$"
        addValueButton.setTitle("Click to Add Transaction", for: .normal)
        
        switch Constants.transactionType {
        case .savings:
            headerDescriptionLabel.text = "Total Savings Amount:"
            headerValueLabel.text =  String(format: "%.2f", TempItem.savingsTotal)
            tagUIView.removeFromSuperview()
            mainStackView.removeArrangedSubview(tagUIView)
            self.navigationItem.title = "Savings"
            alertMessage = Constants.savingsAlertMessage
        case .spending:
            selectTagsLabel.text = "Select Category:"
            headerDescriptionLabel.text = "Total Spending Amount:"
            headerValueLabel.text = String(format: "%.2f", TempItem.spendingtotal)
            headerValueLabel.textColor = .red
            
            self.navigationItem.title = "Spending"
            alertMessage = Constants.spendingAlertMessage
            setupButtons()
        }
    }
    
    func setupButtons() {
        for (index, button) in tagButtonCollection.enumerated() {
            button.setTitle(buttonTitles[index], for: .normal)
        }
    }
    
    func setUpNavBar(){
        self.navigationController?.view.backgroundColor = UIColor.white
        self.navigationController?.view.tintColor = UIColor.orange
    }
    
    // MARK: - Logic
    
    func addToArray() {
        //Construct data dict
        
        if let value = Float(valueString) {
            let userID = TempItem.user
            let date = Date()
            let transactionDescription = descriptionString
            let transactionAmount = value
            var transactionType = ""
            var tag = ""
            if Constants.transactionType == .spending {
                tag = Constants.tagArray[selectedButton].rawValue
                TempItem.spendingArray.insert(value, at: 0)
                updateTotalExpenditures(savings: nil, spending: value)
                headerValueLabel.text = String(format: "%.2f", TempItem.spendingtotal)
                transactionType = "spending"
            } else {
                tag = "Savings"
                TempItem.savingsArray.insert(value, at: 0)
                updateTotalExpenditures(savings: value, spending: nil)
                headerValueLabel.text = String(format: "%.2f", TempItem.savingsTotal)
                transactionType = "savings"
            }
            let dict = ["userID":userID, "date":date, "transactionDescription":transactionDescription, "transactionAmount":transactionAmount, "transactionType":transactionType, "tag":tag ] as [String : Any] as NSDictionary
            
            // Store in Defaults
            
            let storedItemCount = defaults.integer(forKey: "count")
            let count = storedItemCount + 1
            defaults.set(count, forKey: "count")
            
            defaults.set(dict, forKey: String(count))
            
            //Set as Object
            let transaction = Transaction(dictionary: dict)
            TempItem.transactionArray.insert(transaction, at: 0)
            
        }
        
        tableView.reloadData()
    }
    
    func  updateTotalExpenditures(savings: Float?, spending:Float?) {
        if let savingsAmt = savings {
            TempItem.savingsTotal += savingsAmt
        }
        if let spendingAmt = spending {
            TempItem.spendingtotal += spendingAmt
        }
    }
    
    // MARK: - Actions
    
    @IBAction func tagButtonPressed(_ sender: UIButton) {
        self.view.endEditing(true)
        if selectedButton != sender.tag {
            if selectedButton > 7 {
                selectedButton = sender.tag
            } else {
                tagButtonCollection[selectedButton].backgroundColor = .white
                tagButtonCollection[selectedButton].setTitleColor(.orange, for: .normal)
                selectedButton = sender.tag
            }
        }
        tagButtonCollection[sender.tag].backgroundColor = UIColor.lightGray
        tagButtonCollection[sender.tag].setTitleColor(.white, for: .normal)
    }
    
    @IBAction func addTransactionButtonTapped(_ sender: UIButton) {
        self.view.endEditing(true)
        
        if let description = descriptionTextField.text, let value = valueTextField.text {
            valueString = value
            descriptionString = description
        }
        
        switch Constants.transactionType {
        case .savings:
            if valueString.count == 0 || descriptionString.count == 0 {
                showAlert(alertTitle: Constants.savingsSpendingAlertTitle, alertMessage: alertMessage)
            } else {
                addToArray()
            }
        case .spending:
            if valueString.count == 0 || descriptionString.count == 0 || selectedButton > 7 {
                showAlert(alertTitle: Constants.savingsSpendingAlertTitle, alertMessage: alertMessage)
            } else {
                addToArray()
                tagButtonCollection[selectedButton].backgroundColor = .white
                tagButtonCollection[selectedButton].setTitleColor(.orange, for: .normal)
                selectedButton = 9
            }
        }
        valueTextField.text = ""
        descriptionTextField.text = ""
        
    }
    
    // MARK: - TableView Methods
    
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
            let transactionDescription = array[indexPath.row].transactionDescription,
            let amount = array[indexPath.row].transactionAmount {
            let amountString = String(format: "%.2f", amount)
            cell.textLabel?.adjustsFontSizeToFitWidth = true
            cell.detailTextLabel?.adjustsFontSizeToFitWidth = true
            
            cell.textLabel?.text       = "\(date.stripTime(currentDate: date))    \(transactionDescription)"
            
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
