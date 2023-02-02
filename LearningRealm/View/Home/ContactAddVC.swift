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
    
    var homeVM: HomeViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupUI()
        bindingModel()
        defineLayout()
        loadData()
    }
    
    private func setupUI() {
        addBG(color: AppColors.background)
        
        title = "New Contact"
        let cancelBtn = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelBtnTapped))
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneBtnTapped))

        navigationItem.leftBarButtonItem = cancelBtn
        navigationItem.rightBarButtonItem = doneBtn
        
        [fieldListTableView].forEach { view in
            self.view.addSubview(view)
        }
        
        fieldListTableView.register(ContactFieldCell.self, forCellReuseIdentifier: ContactFieldCell.identifier)
    }
    
    private func bindingModel() {
        homeVM = HomeViewModel()
    }
    
    private func defineLayout() {
        fieldListTableView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(0.s)
            make.topMargin.equalTo(50.s)
            make.trailing.equalToSuperview().offset(0.s)
            make.bottom.equalToSuperview().offset(0.s)
        }
    }
    
    private func loadData() {
        
    }
    
    @objc private func cancelBtnTapped() {
        self.dismiss(animated: true)
    }
    
    @objc private func doneBtnTapped() {
        
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
        cell.setupCell(indexPath: indexPath)
        return cell
    }
}
