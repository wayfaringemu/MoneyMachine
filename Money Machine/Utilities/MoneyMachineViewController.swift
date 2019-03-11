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
//    var transaction: Transaction!
//    var userObject: UserObject?
    
//    lazy var categories: Results<Category> = { self.realm.objects(Category.self) }()
    
    
    let context = Constants().appDelegate?.persistentContainer.viewContext
    var transactionArray: Array<Transaction>?
    
    
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
    
    func saveData(transaction: [Transaction]) {
        
        if let appContext = context, let entity = NSEntityDescription.entity(forEntityName: "User", in: appContext) {
            
            let newTransaction = StoredTransaction(entity: entity, insertInto: appContext)
            
//            newTransaction.transactionArray = Constants.expensesArray
            
            do {
                try appContext.save()
                
            } catch {
                print("Failed saving")
            }
        }
        
    }
    
    
    func retreiveData() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        //request.predicate = NSPredicate(format: "age = %@", "12")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context?.fetch(request)
            for data in result as! [NSManagedObject] {
                print(data.value(forKey: "transactionArray") as! [Transaction])
                if let transactionArray = data.value(forKey: "transactionArray") as? [Transaction] {
//                    Constants.expensesArray = transactionArray
                }
                
            }
            
        } catch {
            
            print("Failed")
        }
    }
    
    
}
