//
//  UIView+Extension.swift
//  Khushu
//
//  Created by Elo on 27/4/19.
//  Copyright © 2019 Elo. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    /**
     Rounds the given set of corners to the specified radius
     
     - parameter corners: Corners to round
     - parameter radius:  Radius to round to
     */
    func round(corners: UIRectCorner, radius: CGFloat) {
//        _ = _round(corners: corners, radius: radius)
        let mask = _round(corners: corners, radius: radius)
        addBorder(mask: mask, borderColor: UIColor.clear, borderWidth: 0.0)
    }
    
    /**
     Rounds the given set of corners to the specified radius with a border
     
     - parameter corners:     Corners to round
     - parameter radius:      Radius to round to
     - parameter borderColor: The border color
     - parameter borderWidth: The border width
     */
    func round(corners: UIRectCorner, radius: CGFloat, borderColor: UIColor, borderWidth: CGFloat) {
        let mask = _round(corners: corners, radius: radius)
        addBorder(mask: mask, borderColor: borderColor, borderWidth: borderWidth)
    }
    
    func round(radius: CGFloat, borderColor: UIColor, borderWidth: CGFloat) {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = radius
        if borderWidth > 0.0 {
            self.layer.borderWidth = borderWidth
            self.layer.borderColor = borderColor.resolvedColor(with: AppManager.shared.traitCollection ?? self.traitCollection).cgColor
        }
    }
    
    func round(radius: CGFloat) {
        self.round(radius: radius, borderColor: UIColor.clear, borderWidth: 0.0)
    }
    
    // Example use: myView.addBorder(toSide: .Left, withColor: UIColor.redColor().CGColor, andThickness: 1.0)
    
    enum ViewSide {
        case left, right, top, bottom
    }
    
    func addBorder(toSide side: ViewSide, withColor color: CGColor, andThickness thickness: CGFloat) {
        
        let border = CALayer()
        border.backgroundColor = color
        
        switch side {
        case .left: border.frame = CGRect(x: 0, y: 0, width: thickness, height: self.frame.size.height)
        case .right: border.frame = CGRect(x: self.frame.size.width - thickness, y: 0, width: thickness, height: self.frame.size.height)
        case .top: border.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: thickness)
        case .bottom: border.frame = CGRect(x: 0, y: self.frame.size.height - thickness, width: self.frame.size.width, height: thickness)
        }
        
        layer.addSublayer(border)
    }
    
    func addBorder(borderColor: UIColor, borderWidth: CGFloat, cornerRadius: CGFloat = 0) {
        layer.masksToBounds = true
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor
        if cornerRadius > 0 {
            layer.cornerRadius = cornerRadius
        }
    }
    
    enum GradientMode {
        case horizontal, vertical
    }
    
    func addGradient(_colors: [CGColor], _locations: [NSNumber], _gradientMode: GradientMode) {
        let gradient: CAGradientLayer = CAGradientLayer()
        
        gradient.colors = _colors
        gradient.locations = _locations
        if _gradientMode == .horizontal {
            gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
            gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        } else {
            gradient.startPoint = CGPoint(x: 0.5, y: 0.0)
            gradient.endPoint = CGPoint(x: 0.5, y: 1.0)
        }
        gradient.frame = CGRect(x: 0.0, y: 0.0, width: self.frame.size.width, height: self.frame.size.height)
        
        self.layer.addSublayer(gradient)
    }
    
    func addGradient(color1: UIColor, color2: UIColor) {
        let gradient: CAGradientLayer = CAGradientLayer()
        
        gradient.colors = [color1.cgColor, color2.cgColor]
        gradient.locations = [0.0, 1.0]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradient.frame = CGRect(x: 0.0, y: 0.0, width: self.frame.size.width, height: self.frame.size.height)
        
        self.layer.addSublayer(gradient)
    }
    
    // roundWithShadow function works well all UIView elements except UITextView
    // if apply roundWithShadow to UITextView then the text is going upper from the bounds frame.
    func roundWithShadow(_cornerRadius: CGFloat, _x: CGFloat, _y: CGFloat, _blar: CGFloat, _spread: CGFloat = 0.0, _shadowOpacity: Float = 1.0, _shadowColor: UIColor) {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = _cornerRadius
        
//        To apply Shadow
        self.layer.masksToBounds = false
        self.layer.shadowOpacity = _shadowOpacity
        self.layer.shadowRadius = _blar / 2.0
        self.layer.shadowOffset = CGSize(width: _x, height: _y) // Use any CGSize
        self.layer.shadowColor = _shadowColor.cgColor
        if _spread == 0 {
            self.layer.shadowPath = nil
        } else {
            let dx = -_spread
            let rect = bounds.insetBy(dx: dx, dy: dx)
            self.layer.shadowPath = UIBezierPath(rect: rect).cgPath
        }
    }
    
    func removeShadow() {
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowColor = UIColor.clear.cgColor
        self.layer.shadowRadius = 0.0
        self.layer.shadowOpacity = 0.0
    }
    
    func showShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.18
        layer.shadowOffset = CGSize(width: 6, height: 6)
        layer.shadowRadius = 15.s
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    func addShadow(shadowColor: UIColor, offSet: CGSize, opacity: Float, shadowRadius: CGFloat, cornerRadius: CGFloat, corners: UIRectCorner = [.topLeft, .topRight, .bottomLeft, .bottomRight], fillColor: UIColor = .white) {
        
        let shadowLayer = CAShapeLayer()
        let size = CGSize(width: cornerRadius, height: cornerRadius)
        let cgPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: size).cgPath
        shadowLayer.path = cgPath
        shadowLayer.fillColor = fillColor.cgColor
        shadowLayer.shadowColor = shadowColor.cgColor
        shadowLayer.shadowPath = cgPath
        shadowLayer.shadowOffset = offSet
        shadowLayer.shadowOpacity = opacity
        shadowLayer.shadowRadius = shadowRadius
        shadowLayer.name =  "shadowLayer"
        
        self.removeLayer(layerName: "shadowLayer")
        self.layer.cornerRadius = cornerRadius
        self.layer.borderColor =  UIColor.black.withAlphaComponent(0.15).cgColor
        self.layer.borderWidth = 0.5
        self.layer.insertSublayer(shadowLayer, at: 0)
    }
    
    func removeLayer(layerName: String) {
        for item in self.layer.sublayers ?? [] where item.name == layerName {
            item.removeFromSuperlayer()
        }
    }
    
    func pushTransition(_ duration: CFTimeInterval) {
        let animation: CATransition = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        animation.type = CATransitionType.push
        animation.subtype = CATransitionSubtype.fromRight
        animation.duration = duration
        layer.add(animation, forKey: "transitionpush")
    }
    
    func rotate() {
        let rotation: CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = NSNumber(value: Double.pi * 2)
        rotation.duration = 40
        rotation.isCumulative = true
        rotation.repeatCount = Float.greatestFiniteMagnitude
        self.layer.add(rotation, forKey: "rotationAnimation")
    }
    
    func move(toPosition: CGPoint, duration: CGFloat, delay: CGFloat) {
        let fromPosition: CGPoint = CGPoint.zero
        let movement = CABasicAnimation(keyPath: "position")
        movement.isAdditive = true
        movement.fromValue =  NSValue(cgPoint: fromPosition)
        movement.toValue =  NSValue(cgPoint: toPosition)
        movement.duration = duration
        movement.repeatCount = Float.greatestFiniteMagnitude
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) { [weak self] in
            self?.layer.add(movement, forKey: "move")
        }
    }
    
    func orbitalRotate(radius: CGFloat, delay: CGFloat) {
        let orbit = CAKeyframeAnimation(keyPath: "position")
        var affineTransform = CGAffineTransform(rotationAngle: 0.0)
        affineTransform = affineTransform.rotated(by: CGFloat(Double.pi))
        let circlePath = UIBezierPath(arcCenter: CGPoint.zero, radius: radius, startAngle: CGFloat(0), endAngle: CGFloat(Double.pi * 2), clockwise: true)
        orbit.path = circlePath.cgPath
        orbit.duration = 20
        orbit.isAdditive = true
        orbit.repeatCount = Float.greatestFiniteMagnitude
        orbit.calculationMode = CAAnimationCalculationMode.paced
        orbit.rotationMode = CAAnimationRotationMode.rotateAuto

        DispatchQueue.main.asyncAfter(deadline: .now() + delay) { [weak self] in
            self?.layer.add(orbit, forKey: "orbit")
        }
    }
}

extension UIView {
    func findViewController() -> UIViewController? {
        if let nextResponder = self.next as? UIViewController {
            return nextResponder
        } else if let nextResponder = self.next as? UIView {
            return nextResponder.findViewController()
        } else {
            return nil
        }
    }
    
    func removeSubviews() {
        self.subviews.forEach { (item) in
            item.removeFromSuperview()
        }
    }
    
}

private extension UIView {
    
    @discardableResult func _round(corners: UIRectCorner, radius: CGFloat) -> CAShapeLayer {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
        return mask
    }
    
    func addBorder(mask: CAShapeLayer, borderColor: UIColor, borderWidth: CGFloat) {
        let borderLayer = CAShapeLayer()
        borderLayer.path = mask.path
        borderLayer.fillColor = UIColor.clear.cgColor
        borderLayer.strokeColor = borderColor.cgColor
        borderLayer.lineWidth = borderWidth
        borderLayer.frame = bounds
        layer.addSublayer(borderLayer)
    }
    
}

extension UIView {
    class func fromNib<T: UIView>() -> T? {
        print("String(describing: T.self) \(String(describing: T.self))")
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil)?.first as? T
    }
    
    static func createSwitch() -> UISwitch {
        let uiSwitch = UISwitch(frame: CGRect.zero)
        uiSwitch.translatesAutoresizingMaskIntoConstraints = false
        return uiSwitch
    }
    
    static func createLabel(text: AppTexts?) -> UILabel {
        return createLabel(text?.rawValue.tr)
    }
    
    static func createLabel(_ text: String? = nil) -> UILabel {
        let label: UILabel = UILabel()
        label.text = text
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    static func createButton(imageName: AppImages? = nil) -> UIButton {
        return createButton(imageName?.rawValue)
    }
    
    static func createButton(_ imageName: String? = nil) -> UIButton {
        let button: UIButton = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(named: imageName ?? ""), for: .normal)
        return button
    }
    
    static func createButton(title: AppTexts?) -> UIButton {
        return createButton(title: title?.rawValue.tr)
    }
    
    static func createButton(title: String?) -> UIButton {
        let button: UIButton = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = .InterRegular(ofSize: 12.s)
        return button
    }
    
    static func createImageView(imageName: AppImages?) -> UIImageView {
        return createImageView(imageName?.rawValue)
    }
    
    static func createImageView(_ imageName: String? = nil) -> UIImageView {
        let imageView: UIImageView = UIImageView()
        if imageName != nil {
            imageView.image = UIImage(named: imageName!)
        }
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }
    
    static func createView() -> UIView {
        let cView: UIView = UIView()
        cView.backgroundColor = UIColor.white
        cView.translatesAutoresizingMaskIntoConstraints = false
        return cView
    }
    
     static func createPrimaryButton(_ title: AppTexts? = nil, buttonSize: CGSize) -> UIButton {
        let button = UIButton(frame: CGRect(x: 0.0, y: 0.0, width: buttonSize.width, height: buttonSize.height))
        button.setTitle(title?.rawValue.tr, for: .normal)
        return button
    }
    
    static func createSmallButton(_ title: AppTexts? = nil) -> UIButton {
        let button = createPrimaryButton(title, buttonSize: CGSize(width: 166.s, height: 44.s))
        
        return button
    }
    
    static func createLargeButton(_ title: AppTexts? = nil) -> UIButton {
        let button = createPrimaryButton(title, buttonSize: CGSize(width: 290.s, height: 40.s))
        
        return button
    }
    
    static func createUITextField(_placeholder: String?, _delegate: UITextFieldDelegate?) -> UITextField {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = true
        textField.delegate = _delegate
    
        textField.placeholder = _placeholder
        textField.borderStyle = .none
        textField.autocapitalizationType     = .none
        textField.autocorrectionType         = .no
        textField.clearButtonMode            = .whileEditing
        textField.contentVerticalAlignment   = .center
        textField.font                       = .InterSemiBold(ofSize: 14.sp)
        textField.textColor                  = AppColors.white
        textField.tintColor                  = AppColors.white
        textField.attributedPlaceholder = NSAttributedString(string: textField.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor: AppColors.gray, NSAttributedString.Key.kern: 1.0])
        textField.backgroundColor            = UIColor.clear
        
        return textField
    }

    static func createTextField(placeholder: AppTexts?, leftIcon: AppImages?, rightIcon: AppImages?, fDelegate: PrimaryTextFieldDelegate?) -> PrimaryTextField {
        return createTextField(placeholder: placeholder?.rawValue, leftIcon: leftIcon?.rawValue, rightIcon: rightIcon?.rawValue, fDelegate: fDelegate)
    }
    
    static func createTextField(placeholder: String?, leftIcon: String?, rightIcon: String?, fDelegate: PrimaryTextFieldDelegate?) -> PrimaryTextField {
        let textField = PrimaryTextField(frame: CGRect(x: 0, y: 0, width: 290.s, height: 40.s))
        textField.textFDelegate = fDelegate
        textField.placeholder = placeholder?.tr
        if leftIcon != nil {
            textField.setLeftIcon(UIImage(named: leftIcon!)!, _userInteractionEnabled: false)
        }
        if rightIcon != nil {
            textField.setRightIcon(UIImage(named: rightIcon!), _userInteractionEnabled: true)
        }
        return textField
    }
    
    static func createSearchTextField(placeholder: AppTexts?) -> UISearchTextField {
        return createSearchTextField(placeholder: placeholder?.rawValue)
    }
    
    static func createSearchTextField(placeholder: String?) -> UISearchTextField {
        let searchField = UISearchTextField()
        searchField.borderStyle = .none
        searchField.backgroundColor = AppColors.white.withAlphaComponent(0.5)
        searchField.placeholder = placeholder?.tr
        return searchField
    }
    
    public static func createTableView(delegate: UITableViewDelegate, dataSource: UITableViewDataSource) -> UITableView {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = delegate
        tableView.dataSource = dataSource
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.clear
        
        return tableView
    }
    
    public static func createCollectionView(delegate: UICollectionViewDelegate?, dataSource: UICollectionViewDataSource?) -> UICollectionView {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0.s, left: 0.s, bottom: 0.s, right: 0.s)
        layout.minimumInteritemSpacing = 2.s
        layout.minimumLineSpacing = 2.s
        layout.itemSize = CGSize(width: 75.s, height: 90.s)
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delegate = delegate
        collectionView.dataSource = dataSource
        collectionView.backgroundColor = UIColor.clear
        
        return collectionView
    }
    
    public static func createPickerView(delegate: UIPickerViewDelegate, dataSource: UIPickerViewDataSource) -> UIPickerView {
        let pickerView = UIPickerView()
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        pickerView.delegate = delegate
        pickerView.dataSource = dataSource
        pickerView.backgroundColor = UIColor.clear
        
        return pickerView
    }
    
    public static func createScrollView(delegate: UIScrollViewDelegate) -> UIScrollView {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.delegate = delegate
        scrollView.showsVerticalScrollIndicator = false
        
        return scrollView
    }
    
    func visiblity(gone: Bool, dimension: CGFloat = 0.0, attribute: NSLayoutConstraint.Attribute = .height) {
        if let constraint = (self.constraints.filter { $0.firstAttribute == attribute}.first) {
            constraint.constant = gone ? 0.0 : dimension
            self.layoutIfNeeded()
            self.isHidden = gone
        }
    }
    
    var globalPoint: CGPoint? {
        return self.superview?.convert(self.frame.origin, to: nil)
    }

    var globalFrame: CGRect? {
        return self.superview?.convert(self.frame, to: nil)
    }
}
