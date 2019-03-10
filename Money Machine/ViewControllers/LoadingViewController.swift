//
//  LoadingViewController.swift
//  Money Machine
//
//  Created by ryan kowalski on 3/8/19.
//  Copyright © 2019 ryan kowalski. All rights reserved.
//

import UIKit
import CoreData

class LoadingViewController: MoneyMachineViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var loadingScreenImageView: UIImageView!
    @IBOutlet weak var loadingScreenLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        loadingScreenImageView.image = UIImage.init(named: "moneyMachineCoin")
        loadingScreenLabel.text = "Money Machine"
        loadingScreenLabel.font = UIFont.boldSystemFont(ofSize: 32)
        
        let rotation: CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = Double.pi * 2
        rotation.duration = 2.0 
        rotation.isCumulative = true
        rotation.repeatCount = Float.greatestFiniteMagnitude
        loadingScreenImageView.layer.add(rotation, forKey: "rotationAnimation")
        
        //Temp:
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
            self.navigateToNextViewController(nextView: "LandingViewController")
        }
    }
}
