//
//  MoneyMachineViewController.swift
//  Money Machine
//
//  Created by ryan kowalski on 3/9/19.
//  Copyright © 2019 ryan kowalski. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift

class MoneyMachineViewController: UIViewController {
    
    // MARK: - Variables
    let realm = try! Realm()
    
//    lazy var categories: Results<Category> = { self.realm.objects(Category.self) }()
    
    

    
    
    func addNewUserObject(object: Object) {
        try! realm.write {
            try! realm.write {
                realm.add(object)
            }
        }
    }
    
    func updateUserObject() {
        try! realm.write {
//            let userObject = UserObject()
            let currentUser = Constants.usersArray[Constants.userIndexValue] as UserObject

//            userObject.userId = UserInfo().userId
//            userObject.userPass = UserInfo().userPass
//            userObject.totalSavings = UserInfo().savingsMoney
//            userObject.totalSpending = UserInfo().spendingMoney
//            userObject.transactionArray = UserInfo().transactionArray
        }
    }
    
    
    
    
    // MARK: - Dismiss Keyboard
    
    override func touchesBegan(_ touches: Set<UITouch>,
                               with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // MARK: - Navigation
    
    func navigateToNextViewController(nextView: String) {
        if let VC1 = self.storyboard?.instantiateViewController(withIdentifier: "\(nextView)")  {
            let navController = UINavigationController(rootViewController: VC1)
            self.present(navController, animated:true, completion: nil)
        }
    }

    // MARK: - Alert
    
    func showAlert(alertTitle: String, alertMessage: String) {
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    
    // MARK: - Core Data
    
    func saveData(transaction: Transaction) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "CDTransaction", in: context)
        let newUser = NSManagedObject(entity: entity!, insertInto: context)

        newUser.setValue(transaction.userID, forKey: "userID")
        newUser.setValue(transaction.date, forKey: "date")
        newUser.setValue(transaction.transactionDescription, forKey: "transactionDescription")
        
        // Need ton convert below to Strings
        
//        newUser.setValue(transaction.transactionAmount, forKey: "transactionAmount")
        newUser.setValue(transaction.tag, forKey: "tag")
//        newUser.setValue(transaction.transactionType, forKey: "transactionType")
        do {
            try context.save()
        } catch {
            print("Failed saving")
        }
        
    }
    
  
    
    
    func retreiveData() {
        let context = Constants().appDelegate?.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "CDTransaction")

        request.returnsObjectsAsFaults = false
        do {
            let result = try context?.fetch(request)
            
            if let array = result as? [Transaction] {
                TempItem.transactionArray = array
            }
            for transaction in TempItem.transactionArray {
                print("transaction for \(String(describing: transaction.userID))")
            }
        } catch {
            
            print("Failed")
        }
    }
}

extension Date {
    func stripTime(currentDate: Date) -> String {
        let dateFormatter:DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString:String = dateFormatter.string(from: currentDate as Date)
        
        return dateString
    }
}

