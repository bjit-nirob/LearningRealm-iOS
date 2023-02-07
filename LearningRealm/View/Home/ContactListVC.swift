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
    
    var contactVM: ContactViewModel!

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
        contactVM = ContactViewModel()
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
        contactVM.loadAllContact()
        contactTableView.reloadData()
    }
    
    @objc private func addBtnTapped() {
        let vc = ContactAddVC()
        vc.didComplete = {[weak self] complete in
            if complete {
                self?.loadData()
            }
        }
        let nvc = UINavigationController(rootViewController: vc)
        self.present(nvc, animated: true)
    }
    
    private func editContact(contactModel: ContactModel) {
        let vc = ContactAddVC()
        contactVM.contactModel = contactModel
        vc.didComplete = {[weak self] complete in
            if complete {
                self?.loadData()
            }
        }
        let nvc = UINavigationController(rootViewController: vc)
        self.present(nvc, animated: true)
    }
    
    private func deleteContact(contactModel: ContactModel) {
        contactVM.deleteContact(contactModel: contactModel)
        loadData()
    }

}

extension ContactListVC: UITableViewDelegate {

}

extension ContactListVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return contactVM.allContactModel.keys.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactVM.allContactModel[contactVM.keys[section]]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ContactCell.identifier, for: indexPath) as? ContactCell else {
            fatalError("ContactCell does not created properly")
        }
        let contactModel = contactVM.allContactModel[contactVM.keys[indexPath.section]]?[indexPath.row]
        cell.setupCell(model: contactModel, indexPath: indexPath)
        return cell
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return contactVM.alphabet
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return contactVM.keys[section]
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editAction = UIContextualAction(style: .normal, title:  "Edit", handler: {[weak self] (contextAction, view, success) in
            if let self = self, let contactModel = self.contactVM.allContactModel[self.contactVM.keys[indexPath.section]]?[indexPath.row] {
                self.editContact(contactModel: contactModel)
            }
            success(true)
        })
        
        return UISwipeActionsConfiguration(actions: [editAction])
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editAction = UIContextualAction(style: .destructive, title:  "Delete", handler: {[weak self] (contextAction, view, success) in
            if let self = self, let contactModel = self.contactVM.allContactModel[self.contactVM.keys[indexPath.section]]?[indexPath.row] {
                self.deleteContact(contactModel: contactModel)
            }
//            tableView.deleteRows(at: [indexPath], with: .bottom)
            success(true)
        })
        
        return UISwipeActionsConfiguration(actions: [editAction])
    }
}
