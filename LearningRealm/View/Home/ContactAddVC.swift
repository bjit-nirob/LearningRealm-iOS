//
//  ContactAddVC.swift
//  LearningRealm
//
//  Created by BJIT on 2/2/23.
//

import UIKit

class ContactAddVC: BaseViewController {
    private lazy var fieldListTableView: UITableView = {
        let tableView = UIView.createTableView(delegate: self, dataSource: self)
        tableView.backgroundColor = AppColors.background
        tableView.estimatedRowHeight = 44.s
        tableView.rowHeight = UITableView.automaticDimension
        return tableView
    }()
    
    var viewModel: ContactAddVM!
    var didComplete: ((Bool) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupUI()
        bindingModel()
        defineLayout()
    }
    
    private func setupUI() {
        addBG(color: AppColors.background)
        
        title = AppTexts.translate_id_0006.rawValue.tr
        let cancelBtn = UIBarButtonItem(title: AppTexts.translate_id_0012.rawValue.tr, style: .plain, target: self, action: #selector(cancelBtnTapped))
        let doneBtn = UIBarButtonItem(title: AppTexts.translate_id_0013.rawValue.tr, style: .plain, target: self, action: #selector(doneBtnTapped))

        navigationItem.leftBarButtonItem = cancelBtn
        navigationItem.rightBarButtonItem = doneBtn
        
        [fieldListTableView].forEach { view in
            self.view.addSubview(view)
        }
        
        fieldListTableView.register(ContactFieldCell.self, forCellReuseIdentifier: ContactFieldCell.identifier)
    }
    
    private func bindingModel() {
        
    }
    
    private func defineLayout() {
        fieldListTableView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(0.s)
            make.topMargin.equalTo(50.s)
            make.trailing.equalToSuperview().offset(0.s)
            make.bottom.equalToSuperview().offset(0.s)
        }
    }
    
    private func saveContact() {
        if viewModel.shouldEdit {
            viewModel.updateContact()
        } else {
            viewModel.saveContact()
        }
    }
    
    @objc private func cancelBtnTapped() {
        self.dismiss(animated: true)
        didComplete?(false)
    }
    
    @objc private func doneBtnTapped() {
        if viewModel.shouldSave() {
            self.saveContact()
            self.dismiss(animated: true)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.didComplete?(true)
            }
        } else {
            showAlert(title: AppTexts.translate_id_0014.rawValue.tr, message: "\n" + AppTexts.translate_id_0015.rawValue.tr) { [weak self] in
                
            }
        }
    }

}

extension ContactAddVC: UITableViewDelegate {
    
}

extension ContactAddVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ContactFieldCell.identifier, for: indexPath) as? ContactFieldCell else {
            fatalError("ContactFieldCell does not created properly")
        }
        cell.cellDelegate = self
        cell.setupCell(model: viewModel.contactModel, indexPath: indexPath)
        return cell
    }
}

extension ContactAddVC: ContactFieldCellDelegate {
    func textFieldDidChanged(textField: PrimaryTextField) {
        switch textField.tag {
        case 0:
            viewModel.contactModel?.firstName = textField.text
        case 1:
            viewModel.contactModel?.lastName = textField.text
        case 2:
            viewModel.contactModel?.mobNumber = textField.text
        default:
            print("Nothing is happened")
        }
    }
}
