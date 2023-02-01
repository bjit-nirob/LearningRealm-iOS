//
//  UIPrimaryTextField.swift
//  Hinatabo
//
//  Created by Islam Md. Zahirul on 17/2/21.
//

import UIKit

@objc protocol PrimaryTextFieldDelegate {
    @objc optional func textFieldShouldBeginEditing(textField: PrimaryTextField) -> Bool
    @objc optional func textFieldShouldReturn(textField: PrimaryTextField, range: NSRange, string: String) -> Bool
    @objc optional func textFieldRightButtonClicked(textField: PrimaryTextField)
    @objc optional func textFieldLeftButtonClicked(textField: PrimaryTextField)
    @objc optional func textFieldDidChanged(textField: PrimaryTextField)
}

class PrimaryTextField: UITextField {
    
    weak var textFDelegate: PrimaryTextFieldDelegate?
    private var leftSpace: CGFloat = 15.s
    
    public override init(frame: CGRect) {
        super.init(frame:frame)
        
        initializeSetup()
        //print("UIPrimaryTextField-init-frame")
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        //initializeSetup()
        //print("UIPrimaryTextField-init-coder")
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        
        initializeSetup()
        //print("UIPrimaryTextField-awakeFromNib")
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    private func initializeSetup() {
        
        self.delegate = self
    
        self.borderStyle = .none
        self.autocapitalizationType     = .none
        self.autocorrectionType         = .no
        self.clearButtonMode            = .whileEditing
        self.contentVerticalAlignment   = .center
        self.font                       = .HiraginoSansW6(ofSize: 21.sp)
        self.textColor                  = .gray
        self.tintColor                  = .gray
//        self.letterSpacing(spacing: 1.0)
        self.attributedPlaceholder = NSAttributedString(string: self.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor: AppColors.gray, NSAttributedString.Key.kern: 1.0])
        self.backgroundColor            = UIColor.clear
        
        self.setUnderLine(height: 1.0.s, color: AppColors.gray)
//        self.setDefaultLeftView()
//        self.setDefaultRightView()
        
        self.addTarget(self, action: #selector(textFieldDidChanged(textField:)), for: .editingChanged)
        
//        self.setDefaultBorder()
        
    }
    
    override var isSecureTextEntry: Bool {
        didSet {
            if isFirstResponder {
                _ = becomeFirstResponder()
            }
        }
    }

    override func becomeFirstResponder() -> Bool {

        let success = super.becomeFirstResponder()
        if isSecureTextEntry, let text = self.text {
            self.text?.removeAll()
            insertText(text)
        }
        return success
    }
    
    public func setPasswordSecureText(isSecure: Bool) {
        self.isSecureTextEntry = isSecure
    }
    
    public func setDefaultBorder() {
        self.round(radius: 6.0.s, borderColor: AppColors.gray, borderWidth: 1.5.s)
    }
    
    public func setRedBorder() {
        self.round(radius: 6.0.s, borderColor: AppColors.red, borderWidth: 1.5.s)
    }
    
    public func setDefaultLeftView(_userInteractionEnabled: Bool = false) {
        let lview = UIView()
        lview.frame = CGRect(x: 0, y: 0, width: leftSpace, height: self.bounds.size.height)
        lview.backgroundColor = UIColor.clear
        lview.isUserInteractionEnabled = _userInteractionEnabled
        self.leftView = lview
        self.leftViewMode = .always
    }
    
    public func setDefaultRightView(_userInteractionEnabled: Bool = false) {
        let rview = UIView()
        rview.frame = CGRect(x: 0, y: 0, width: leftSpace, height: self.bounds.size.height)
        rview.backgroundColor = UIColor.clear
        rview.isUserInteractionEnabled = _userInteractionEnabled
        self.rightView = rview
        self.rightViewMode = .always
    }
    
    public func setLeftIcon(_ image: UIImage, _userInteractionEnabled: Bool = false) {
        
        //let iconSize:CGSize = CGSize(width: self.bounds.size.height*0.4, height: self.bounds.size.height*0.4)
        let iconSize:CGSize = image.size
        //print("setLeftIcon image size \(iconSize.width) \(iconSize.height)")
        let iconContainerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: iconSize.width + leftSpace, height: iconSize.height+0.0))
        
        let iconView = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width: iconSize.width, height: iconSize.height))
        iconView.contentMode = .scaleAspectFit
        iconView.image = image
        iconView.isUserInteractionEnabled = _userInteractionEnabled
        iconContainerView.isUserInteractionEnabled = _userInteractionEnabled
        
        iconContainerView.addSubview(iconView)
        self.leftView = iconContainerView
        self.leftViewMode = .always
        
        let gesture = UITapGestureRecognizer.init(target: self, action: #selector(textFieldLeftButtonClicked(gesture:)))
        gesture.numberOfTapsRequired = 1
        iconContainerView.addGestureRecognizer(gesture)
    }
    
    public func setRightIcon(_ image: UIImage?, _userInteractionEnabled: Bool = false) {
        
        let iconSize:CGSize = image?.size ?? CGSize(width: 0, height: 0)
        
        let iconContainerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: iconSize.width+9.0, height: iconSize.height+0.0))
        
        let iconView = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width: iconSize.width, height: iconSize.height))
        iconView.contentMode = .scaleAspectFit
        iconView.image = image
        iconView.isUserInteractionEnabled = _userInteractionEnabled
        iconContainerView.isUserInteractionEnabled = _userInteractionEnabled
        
        iconContainerView.addSubview(iconView)
        self.rightView = iconContainerView
        self.rightViewMode = .always
        
        //textFieldRightButtonClicked
        let gesture = UITapGestureRecognizer.init(target: self, action: #selector(textFieldRightButtonClicked(gesture:)))
        gesture.numberOfTapsRequired = 1
        iconContainerView.addGestureRecognizer(gesture)
    }
    
    @objc private func textFieldDidChanged(textField: PrimaryTextField) {
        //print("textFieldDidChanged \(textField.text ?? "nulllll")")
        textFDelegate?.textFieldDidChanged?(textField: textField)
    }
    
    @objc private func textFieldRightButtonClicked(gesture: UITapGestureRecognizer) {
        guard let method = textFDelegate?.textFieldRightButtonClicked else {
            return
        }
        method(self)
    }
    
    @objc private func textFieldLeftButtonClicked(gesture: UITapGestureRecognizer) {
        //print("optionClicked tag \(gesture.tag)")
        guard let method = textFDelegate?.textFieldLeftButtonClicked else {
            return
        }
        method(self)
    }
    
    public func addSelectedProperties() {
        //addBorderProperties(borderWidth: 2.0, borderColor: NHTheme.shared.THEME_DEEP_GREEN, shadowColor: NHTheme.shared.THEME_PURE_WHITE)
        textFieldDidBeginEditing(self)
    }
    
    public func addNonSelectedProperties() {
        //clearBorderProperties()
        textFieldDidEndEditing(self)
    }
    
    private func addBorderProperties(borderWidth:CGFloat, borderColor:UIColor, shadowColor:UIColor) {
        
        //To apply border
        //self.layer.borderWidth = borderWidth
        //self.layer.borderColor = borderColor.cgColor
        
        //To apply Shadow
        self.layer.shadowOpacity = 0.15
        self.layer.shadowRadius = 3.0
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0) // Use any CGSize
        self.layer.shadowColor = shadowColor.cgColor
    }
    
    func styleTextField() {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 3.0
        
        //To apply Shadow
        self.layer.masksToBounds = false
        self.layer.shadowOpacity = 0.15
        self.layer.shadowRadius = 6.0
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0) // Use any CGSize
        self.layer.shadowColor = UIColor.black.cgColor
    }
    
    private func clearBorderProperties() {
        
        //To apply border
        self.layer.borderColor = UIColor.clear.cgColor
        
        //To apply Shadow
        self.layer.shadowOpacity = 0.0
        self.layer.shadowRadius = 0.0
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0) // Use any CGSize
        self.layer.shadowColor = UIColor.clear.cgColor
    }

}

extension PrimaryTextField: UITextFieldDelegate {
    // Mark- UITextFieldDelegate
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
//        addBorderProperties(borderWidth: 2.0, borderColor: NHTheme.shared.THEME_DEEP_GREEN, shadowColor: NHTheme.shared.THEME_PURE_WHITE)
        self.setUnderLine(height: 1.5.s, color: AppColors.primaryColor)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
//        clearBorderProperties()
        self.setUnderLine(height: 1.0.s, color: AppColors.gray)
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        //print("textFieldShouldBeginEditing")
        guard let method = textFDelegate?.textFieldShouldBeginEditing else {
            return true
        }
        return method(textField as! PrimaryTextField)
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        /*if self.text != nil && !self.text!.isEmpty && isCapitalized {
            self.text = self.text?.capitalizingFirstLetter()
        }*/
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //print("textFieldShouldBeginEditing")
        guard let method = textFDelegate?.textFieldShouldReturn else {
            return true
        }
        return method(textField as! PrimaryTextField, range, string)
    }
    
}

extension UITextField {

   func addDoneButtonOnKeyboard() {
       let keyboardToolbar = UIToolbar()
       keyboardToolbar.sizeToFit()
       let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
           target: nil, action: nil)
       let doneButton = UIBarButtonItem(barButtonSystemItem: .done,
           target: self, action: #selector(resignFirstResponder))
       keyboardToolbar.items = [flexibleSpace, doneButton]
       self.inputAccessoryView = keyboardToolbar
   }
}
