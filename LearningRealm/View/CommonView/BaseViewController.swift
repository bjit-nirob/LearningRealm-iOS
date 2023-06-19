//
//  BaseViewController.swift
//  TheBeats
//
//  Created by mac 2019 on 8/11/22.
//

import UIKit
import SnapKit
import MBProgressHUD

class BaseViewController: UIViewController {

    // MARK: - Super Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = AppColors.background
        
        let hideKeyboard = UITapGestureRecognizer(target: self, action: #selector(navigationBarTap))
        hideKeyboard.numberOfTapsRequired = 1
        navigationController?.navigationBar.addGestureRecognizer(hideKeyboard)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        self.endEditing()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    private func endEditing() {
        self.view.endEditing(true)
    }
    
    @objc func navigationBarTap() {
        self.endEditing()
    }
    
    func changeTheme(isDark: Bool) {
        if let window = UIApplication.shared.windows.first {
            window.overrideUserInterfaceStyle = isDark ? .dark : .light
        }
    }
    
    func addBG(color: UIColor) {
        self.view.backgroundColor = color
    }
    
    func showHUD() {
        MBProgressHUD.showAdded(to: self.view, animated: true)
    }
    
    func hideHUD() {
        MBProgressHUD.hide(for: self.view, animated: true)
    }
    
    func showAlert(title: String, message: String, actionHandler: (() -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: AppTexts.translate_id_0016.rawValue.tr, style: .default) { _ in
            actionHandler?()
        }
        alert.addAction(okAction)
        self.present(alert, animated: true)
    }

}
