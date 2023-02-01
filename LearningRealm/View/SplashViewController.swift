//
//  SplashViewController.swift
//  TheBeats
//
//  Created by mac 2019 on 8/14/22.
//

import UIKit

class SplashViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        addBG()
        
        bindingModel()
        defineLayout()
        
        let seconds = 2.0
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) { [weak self] in
            self?.decideAction()
        }
    }
    
    private func bindingModel() {
        
    }
    
    private func defineLayout() {
        
    }
    
    private func decideAction() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
                appDelegate.setHomeViewController()
            }
        }
    }

}
