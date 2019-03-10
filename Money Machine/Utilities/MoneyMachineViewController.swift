//
//  MoneyMachineViewController.swift
//  Money Machine
//
//  Created by ryan kowalski on 3/9/19.
//  Copyright © 2019 ryan kowalski. All rights reserved.
//

import UIKit
import CoreData

class MoneyMachineViewController: UIViewController {
    let context = Constants().appDelegate?.persistentContainer.viewContext
    var transactionArray: Array<Transaction>?
    
    override func touchesBegan(_ touches: Set<UITouch>,
                               with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func navigateToNextViewController(nextView: String) {
        if let VC1 = self.storyboard?.instantiateViewController(withIdentifier: "\(nextView)")  {
            let navController = UINavigationController(rootViewController: VC1)
            self.present(navController, animated:true, completion: nil)
        }
    }
    
    func saveData(transaction: Transaction) {
        
        if let appContext = context, let entity = NSEntityDescription.entity(forEntityName: "User", in: appContext) {
            
            let newTransaction = StoredTransaction(entity: entity, insertInto: appContext)
            
            newTransaction.transactionArray = Constants.expensesArray
            
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
                print(data.value(forKey: "transactionArray") as Any)
                
                
            }
            
        } catch {
            
            print("Failed")
        }
    }
}
