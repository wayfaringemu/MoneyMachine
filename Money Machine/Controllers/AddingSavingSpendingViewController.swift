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
    let model = Models()

    // MARK: - Lifecycle Methods
    
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
    
    func selectButton(selectedButton: Int) {
        tagButtonCollection[selectedButton].backgroundColor = UIColor.lightGray
        tagButtonCollection[selectedButton].setTitleColor(.white, for: .normal)
    }
    func deselectButton(selectedButton: Int) {
        tagButtonCollection[selectedButton].backgroundColor = .white
        tagButtonCollection[selectedButton].setTitleColor(.orange, for: .normal)
    }
    
    // MARK: - Actions
    
    @IBAction func tagButtonPressed(_ sender: UIButton) {
        self.view.endEditing(true)
        if selectedButton != sender.tag {
            if selectedButton > 7 {
                selectedButton = sender.tag
            } else {
                deselectButton(selectedButton: selectedButton)
                selectedButton = sender.tag
            }
        }
        selectButton(selectedButton: sender.tag)
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
                headerValueLabel.text = model.setArray(valueString: valueString, descriptionString: descriptionString, selectedButton: selectedButton)
            }
        case .spending:
            if valueString.count == 0 || descriptionString.count == 0 || selectedButton > 7 {
                showAlert(alertTitle: Constants.savingsSpendingAlertTitle, alertMessage: alertMessage)
            } else {
                headerValueLabel.text = model.setArray(valueString: valueString, descriptionString: descriptionString, selectedButton: selectedButton)
                deselectButton(selectedButton: selectedButton)
                selectedButton = 9
            }
        }
        valueTextField.text = ""
        descriptionTextField.text = ""
        tableView.reloadData()
    }
    
    // MARK: - TableView Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return TempItem.transactionArray.count
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
    
    
}
