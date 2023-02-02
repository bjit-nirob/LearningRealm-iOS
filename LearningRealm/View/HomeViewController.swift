//
//  ViewController.swift
//  LearningRealm
//
//  Created by BJIT on 13/1/23.
//

import UIKit
import SnapKit

class HomeViewController: BaseViewController {
    private let homeLbl: UILabel = {
        let label = UIView.createLabel("Home Screen")
        label.font = .InterMedium(ofSize: 16.sp)
        label.textColor = AppColors.accentColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        addBG(color: AppColors.background)
        
        [homeLbl].forEach { view in
            self.view.addSubview(view)
        }
        
        bindingModel()
        defineLayout()
    }
    
    private func bindingModel() {
        
    }
    
    private func defineLayout() {
        homeLbl.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }

}
