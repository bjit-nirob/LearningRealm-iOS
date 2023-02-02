//
//  ViewController.swift
//  LearningRealm
//
//  Created by BJIT on 13/1/23.
//

import UIKit
import SnapKit

class ContactListVC: BaseViewController {
    private lazy var contactTableView: UITableView = {
        let tableView = UIView.createTableView(delegate: self, dataSource: self)
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
        
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Contacts"
        let addBtn = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addBtnTapped))

        navigationItem.rightBarButtonItems = [addBtn]
        
        [contactTableView].forEach { view in
            self.view.addSubview(view)
        }
        
        contactTableView.register(ContactCell.self, forCellReuseIdentifier: ContactCell.identifier)
    }
    
    private func bindingModel() {
        homeVM = HomeViewModel()
    }
    
    private func defineLayout() {
        contactTableView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(0.s)
            make.top.equalToSuperview().offset(0.s)
            make.trailing.equalToSuperview().offset(0.s)
            make.bottom.equalToSuperview().offset(0.s)
        }
    }
    
    private func loadData() {
        
    }
    
    @objc private func addBtnTapped() {
        let vc = ContactAddVC()
        let nvc = UINavigationController(rootViewController: vc)
        self.present(nvc, animated: true)
    }

}

extension ContactListVC: UITableViewDelegate {
    
}

extension ContactListVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return homeVM.alphabet.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ContactCell.identifier, for: indexPath) as? ContactCell else {
            fatalError("ContactCell does not created properly")
        }
        cell.setupCell(indexPath: indexPath)
        return cell
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return homeVM.alphabet
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return homeVM.alphabet[section]
    }
}
