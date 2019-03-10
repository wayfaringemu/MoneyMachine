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
    
    let userInfo = UserInfo()
    
    let buttonTitles = ["Food", "Health", "Home", "Tech", "Vehicle", "Clothes", "Account", "Other"]
    var selectedButton = 9
    var alertMessage = ""
    var valueString = ""
    var descriptionString = ""
    
    override func viewWillAppear(_ animated: Bool) {
        setupView()
    }
    
    func setupView() {
        setUpNavBar()
        descriptionTextField.placeholder = "description"
        valueTextField.placeholder = "$$"
        addValueButton.setTitle("Click to Add Transaction", for: .normal)

        switch Constants.transactionType {
        case .savings:
            headerDescriptionLabel.text = "Total Savings Amount:"
            headerValueLabel.text = String(describing: userInfo.savingsMoney)
            
            tagUIView.removeFromSuperview()
            mainStackView.removeArrangedSubview(tagUIView)
            self.navigationItem.title = "Savings"
            alertMessage = Constants.savingsAlertMessage
        case .spending:
            selectTagsLabel.text = "Select Category:"
            headerDescriptionLabel.text = "Total Spending Amount:"
            headerValueLabel.text = String(describing: userInfo.spendingMoney)
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
    
    func addToArray() {
        let transaction = Transaction()
        transaction.userID = "ryan"
        transaction.date = Date()
        transaction.transactionDescription = descriptionString
        transaction.transactionAmount = Float(valueString)
        if Constants.transactionType == .spending {
            transaction.tag = Constants.tagArray[selectedButton] as Tags
        }
        transaction.transactionType = Constants.transactionType
        Constants.expensesArray.append(transaction)
        self.saveData(transaction: Constants.expensesArray)
        tableView.reloadData()
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
                showAlert()
            } else {
                addToArray()
            }
        case .spending:
            if valueString.count == 0 || descriptionString.count == 0 || selectedButton > 7 {
                showAlert()
            } else {
                addToArray()
            }
        }
        valueTextField.text = ""
        descriptionTextField.text = ""
        tagButtonCollection[selectedButton].backgroundColor = .white
        tagButtonCollection[selectedButton].setTitleColor(.orange, for: .normal)
        selectedButton = 9
    }
    
    // MARK: - Alert
    
    func showAlert() {
        let alert = UIAlertController(title: Constants.alertTitle, message: alertMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    
    // MARK: - TableView Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return Constants.expensesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell") else {
                return UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: "UITableViewCell")
            }
            return cell
        }()
        
        if let date = Constants.expensesArray[indexPath.row].date,
            let transactionDescription = Constants.expensesArray[indexPath.row].transactionDescription,
            let amount = Constants.expensesArray[indexPath.row].transactionAmount {
            let amountString = String(describing: amount)
            cell.textLabel?.adjustsFontSizeToFitWidth = true
            cell.detailTextLabel?.adjustsFontSizeToFitWidth = true

            cell.textLabel?.text       = "\(date.stripTime(currentDate: date))    \(transactionDescription)"
            
            if let tagType = Constants.expensesArray[indexPath.row].tag {
                cell.detailTextLabel?.text = "\(tagType.rawValue)    $\(amountString)"
            } else {
                cell.detailTextLabel?.text = "$\(amountString)"
            }
        } else {
            cell.textLabel?.text       = ""
            cell.detailTextLabel?.text = ""
        }
        return cell
        
        
        
        
        
        
        
        
        
        
        
//        if let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionUITableViewCell") as? TransactionUITableViewCell,
//                let date = Constants.expensesArray[indexPath.row].date,
//                let transactionDescription = Constants.expensesArray[indexPath.row].transactionDescription,
//                let amount = Constants.expensesArray[indexPath.row].transactionAmount
//            {
//                cell.dateLabel.text =  date.stripTime(currentDate: date)
//                cell.descriptionLabel.text = transactionDescription
//                let amountString = String(describing: amount)
//                cell.amountLabel.text = "$\(amountString)"
//                if let tagType = Constants.expensesArray[indexPath.row].tag {
//                    cell.tagLabel?.text = tagType.rawValue
//                    cell.tagLabel?.backgroundColor = UIColor.lightGray
//                } else {
//                    cell.tagLabel?.text = ""
//                }
//
//                return cell
//        }
    }
    
    
}

class TransactionUITableViewCell: UITableViewCell {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var tagLabel: UILabel?
    @IBOutlet weak var amountLabel: UILabel!

}

