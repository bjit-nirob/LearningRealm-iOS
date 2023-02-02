//
//  SplashViewController.swift
//  TheBeats
//
//  Created by mac 2019 on 8/14/22.
//

import UIKit
import SnapKit

class SplashViewController: BaseViewController {
    private let splashLbl: UILabel = {
        let label = UIView.createLabel("Splash Screen")
        label.font = .InterMedium(ofSize: 16.sp)
        label.textColor = AppColors.accentColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        addBG(color: AppColors.background)
        
        [splashLbl].forEach { view in
            self.view.addSubview(view)
        }
        
        bindingModel()
        defineLayout()
        
        let seconds = 1.0
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) { [weak self] in
            self?.decideAction()
        }
    }
    
    private func bindingModel() {
        
    }
    
    private func defineLayout() {
        splashLbl.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    private func decideAction() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
                appDelegate.setHomeViewController()
            }
        }
    }

}
