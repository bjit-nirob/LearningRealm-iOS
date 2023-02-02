//
//  ContactCell.swift
//  LearningRealm
//
//  Created by BJIT on 2/2/23.
//

import UIKit
import SnapKit

class ContactCell: BaseCell {
    private let containerView: UIView = {
        let view = UIView.createView()
        view.backgroundColor = AppColors.background
        return view
    }()
    
    private let profileImgView: UIImageView = {
        let imgView = UIView.createImageView(imageName: .logo)
        imgView.round(radius: 20.s)
        return imgView
    }()
    
    private let nameLbl: UILabel = {
        let label = UIView.createLabel("")
        label.font = .InterBold(ofSize: 16.sp)
        label.textAlignment = .left
        label.textColor = AppColors.accentColor
        return label
    }()
    
    private let mobNumLbl: UILabel = {
        let label = UIView.createLabel("")
        label.font = .InterMedium(ofSize: 14.sp)
        label.textAlignment = .left
        label.textColor = AppColors.accentColor
        return label
    }()
    
    private let bottomLineView: UIView = {
        let view = UIView.createView()
        view.backgroundColor = .lightGray.withAlphaComponent(0.3)
        return view
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
        self.contentView.addSubview(containerView)
        [profileImgView, nameLbl, mobNumLbl, bottomLineView].forEach { view in
            containerView.addSubview(view)
        }
        
        containerView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(0.s)
            make.bottom.equalToSuperview().offset(-2.s)
            make.leading.equalToSuperview().offset(0.s)
            make.trailing.equalToSuperview().offset(-0.s)
        }
        
        profileImgView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16.s)
            make.top.equalToSuperview().offset(16.s)
            make.height.equalTo(40.s)
            make.width.equalTo(40.s)
        }
        
        nameLbl.snp.makeConstraints { make in
            make.leading.equalTo(profileImgView.snp.trailing).offset(16.s)
            make.top.equalToSuperview().offset(16.s)
            make.trailing.equalToSuperview().offset(-16.s)
        }
        
        mobNumLbl.snp.makeConstraints { make in
            make.leading.equalTo(profileImgView.snp.trailing).offset(16.s)
            make.top.equalTo(nameLbl.snp.bottom).offset(8.s)
            make.trailing.equalToSuperview().offset(-16.s)
            make.bottom.equalToSuperview().offset(-16.s)
        }
        
        bottomLineView.snp.makeConstraints { make in
            make.leading.equalTo(profileImgView.snp.trailing).offset(16.s)
            make.trailing.equalToSuperview().offset(-0.s)
            make.bottom.equalToSuperview().offset(-0.s)
            make.height.equalTo(1.s)
        }
    }
    
    func setupCell(indexPath: IndexPath) {
        nameLbl.text = "Name \(indexPath.row)"
        mobNumLbl.text = "Mobile \(indexPath.row)"
    }

}
