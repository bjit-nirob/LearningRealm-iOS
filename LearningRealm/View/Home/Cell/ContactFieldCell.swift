//
//  ContactCell.swift
//  LearningRealm
//
//  Created by BJIT on 2/2/23.
//

import UIKit
import SnapKit

class ContactFieldCell: BaseCell {
    private let containerView: UIView = {
        let view = UIView.createView()
        view.backgroundColor = AppColors.background
        return view
    }()
    
    private lazy var textField: PrimaryTextField = {
        let textField = UIView.createTextField(placeholder: "", leftIcon: nil, rightIcon: nil, fDelegate: self)
        textField.autocapitalizationType = .words
        return textField
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: ContactCell.identifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setupUI() {
        self.selectionStyle = .none
        
        self.contentView.addSubview(containerView)
        [textField].forEach { view in
            containerView.addSubview(view)
        }
        
        containerView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(0.s)
            make.bottom.equalToSuperview().offset(-0.s)
            make.leading.equalToSuperview().offset(0.s)
            make.trailing.equalToSuperview().offset(-16.s)
        }
        
        textField.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16.s)
            make.top.equalToSuperview().offset(8.s)
            make.trailing.equalToSuperview().offset(-0.s)
            make.bottom.lessThanOrEqualTo(-8.s)
            make.height.equalTo(40.s)
        }
    }
    
    func setupCell(indexPath: IndexPath) {
        textField.tag = indexPath.row
        
        switch indexPath.row {
        case 0:
            textField.keyboardType = .default
            textField.placeholder = "First Name"
        case 1:
            textField.keyboardType = .default
            textField.placeholder = "Last Name"
        case 2:
            textField.keyboardType = .phonePad
            textField.placeholder = "Mobile Number"
        default:
            textField.placeholder = ""
        }
    }

}

extension ContactFieldCell: PrimaryTextFieldDelegate {
    
}
