//
//  MoneyMachineViewController.swift
//  Money Machine
//
//  Created by ryan kowalski on 3/9/19.
//  Copyright © 2019 ryan kowalski. All rights reserved.
//

import UIKit

class MoneyMachineViewController: UIViewController {
    
    // MARK: - Variables
    
    let defaults = UserDefaults.standard
    
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
}

extension Date {
    func stripTime(currentDate: Date) -> String {
        let dateFormatter:DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString:String = dateFormatter.string(from: currentDate as Date)
        
        return dateString
    }
}
