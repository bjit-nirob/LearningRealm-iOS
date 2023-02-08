//
//  ViewController.swift
//  LearningRealm
//
//  Created by BJIT on 13/1/23.
//

import UIKit
import SnapKit

class ContactListVC: BaseViewController {
    
    private lazy var searchBar: UISearchBar = {
        let searchB = UISearchBar()
        searchB.delegate = self
        searchB.backgroundColor = AppColors.background
        searchB.barTintColor = AppColors.background
        searchB.setBackgroundImage(UIImage(named: AppImages.transparent.rawValue), for: .any, barMetrics: .default)
        searchB.placeholder = "Search"
        searchB.translatesAutoresizingMaskIntoConstraints = false
        return searchB
    }()
    
    private let hintLbl: UILabel = {
        let lbl = UIView.createLabel("No Contacts")
        lbl.numberOfLines = 0
        lbl.lineBreakMode = .byWordWrapping
        lbl.textAlignment = .center
        lbl.textColor = AppColors.accentColor
        lbl.font = .InterRegular(ofSize: 24.s)
        return lbl
    }()
    
    private lazy var contactTableView: UITableView = {
        let tableView = UIView.createTableView(delegate: self, dataSource: self)
        tableView.estimatedRowHeight = 44.s
        tableView.rowHeight = UITableView.automaticDimension
        return tableView
    }()
    
    var viewModel: ContactListVM!

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
        
        [searchBar, hintLbl, contactTableView].forEach { view in
            self.view.addSubview(view)
        }
        
        contactTableView.register(ContactCell.self, forCellReuseIdentifier: ContactCell.identifier)
    }
    
    private func bindingModel() {
        viewModel = ContactListVM()
    }
    
    private func defineLayout() {
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(self.view.snp.topMargin).offset(0.s)
            make.centerX.equalToSuperview()
            make.height.equalTo(40.s)
            make.width.equalTo(335.s)
        }
        
        contactTableView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(0.s)
            make.top.equalTo(searchBar.snp.bottom).offset(0.s)
            make.trailing.equalToSuperview().offset(0.s)
            make.bottom.equalToSuperview().offset(0.s)
        }
        
        hintLbl.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    private func loadData() {
        viewModel.loadAllContact()
        contactTableView.reloadData()
        hintLbl.isHidden = (viewModel.allContactModel.count) != 0
    }
    
    @objc private func addBtnTapped() {
        let contactAddVM = ContactAddVM()
        contactAddVM.contactModel = ContactModel()
        let vc = ContactAddVC()
        vc.viewModel = contactAddVM
        vc.didComplete = {[weak self] complete in
            if complete {
                self?.loadData()
            }
        }
        let nvc = UINavigationController(rootViewController: vc)
        self.present(nvc, animated: true)
    }
    
    private func editContact(contactModel: ContactModel) {
        let contactAddVM = ContactAddVM()
        contactAddVM.shouldEdit = true
        if let contactM = contactModel.copy() as? ContactModel {
            contactAddVM.contactModel = contactM
        }
        let vc = ContactAddVC()
        vc.viewModel = contactAddVM
        vc.didComplete = {[weak self] complete in
            if complete {
                self?.loadData()
            }
        }
        let nvc = UINavigationController(rootViewController: vc)
        self.present(nvc, animated: true)
    }
    
    private func deleteContact(contactModel: ContactModel) {
        viewModel.deleteContact(contactModel: contactModel)
        loadData()
    }
    
    private func handleSearch() {
        searchBar.resignFirstResponder()
        loadData()
        contactTableView.setContentOffset(CGPoint.zero, animated: false)
    }

}

extension ContactListVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editAction = UIContextualAction(style: .normal, title: "Edit", handler: {[weak self] (_, _, success) in
            if let self = self, let contactModel = self.viewModel.allContactModel[self.viewModel.keys[indexPath.section]]?[indexPath.row] {
                self.editContact(contactModel: contactModel)
            }
            success(true)
        })
        
        return UISwipeActionsConfiguration(actions: [editAction])
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editAction = UIContextualAction(style: .destructive, title: "Delete", handler: {[weak self] (_, _, success) in
            if let self = self, let contactModel = self.viewModel.allContactModel[self.viewModel.keys[indexPath.section]]?[indexPath.row] {
                self.deleteContact(contactModel: contactModel)
            }
            success(true)
        })
        
        return UISwipeActionsConfiguration(actions: [editAction])
    }
}

extension ContactListVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.allContactModel.keys.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.allContactModel[viewModel.keys[section]]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ContactCell.identifier, for: indexPath) as? ContactCell else {
            fatalError("ContactCell does not created properly")
        }
        let contactModel = viewModel.allContactModel[viewModel.keys[indexPath.section]]?[indexPath.row]
        cell.setupCell(model: contactModel, indexPath: indexPath)
        return cell
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return viewModel.alphabet
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.keys[section]
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}

extension ContactListVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchText = searchText
        if searchText.isEmpty {
            handleSearch()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("searchBarCancelButtonClicked")
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        handleSearch()
    }
}
