//
//  SplashViewController.swift
//  TheBeats
//
//  Created by mac 2019 on 8/14/22.
//

import UIKit
import SnapKit

class SplashVC: BaseViewController {
    private let splashLbl: UILabel = {
        let label = UIView.createLabel(text: .translate_id_0011)
        label.font = .InterMedium(ofSize: 16.sp)
        label.textColor = AppColors.accentColor
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
        
        let seconds = 0.5
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
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            RealmManager.shared.initialize { initialized in
                if initialized {
                    appDelegate.setHomeViewController()
                } else {
                    DispatchQueue.main.async {
                        self.showAlert(title: "Error", message: "Realm initialization error", actionHandler: nil)
                    }
                }
            }
        }
    }

}
