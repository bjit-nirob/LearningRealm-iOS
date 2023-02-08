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
        let tableView = UIView.createTableView(delegate: self, dataSource: nil)
        tableView.estimatedRowHeight = 44.s
        tableView.rowHeight = UITableView.automaticDimension
        return tableView
    }()
    
    // MARK: - Diffable Datasource
    typealias DataSource = ContactListDiffableDataSource
    typealias Snapshot = NSDiffableDataSourceSnapshot<String, ContactModel>
    
    private lazy var dataSource = makeDataSource()
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
    
    private func loadData(indexPath: IndexPath? = nil) {
        viewModel.loadAllContact()
        self.applySnapshot(animatingDifferences: true, indexPath: indexPath)
        self.handleEmptyData()
    }
    
    // MARK: - DataSource
    func makeDataSource() -> DataSource {
        let dataSource = DataSource(tableView: contactTableView, cellProvider: {[weak self] (tableView, indexPath, contactModel) -> UITableViewCell? in
            guard let self = self, let cell = tableView.dequeueReusableCell(withIdentifier: ContactCell.identifier, for: indexPath) as? ContactCell else {
                fatalError("ContactCell is not initialized properly")
            }
            let contactModel = self.viewModel.allContactModel[self.viewModel.keys[indexPath.section]]?[indexPath.row]
            cell.setupCell(model: contactModel, indexPath: indexPath)
            return cell
        })
        dataSource.viewModel = viewModel
        return dataSource
    }
    
    func applySnapshot(animatingDifferences: Bool = true, indexPath: IndexPath? = nil) {
        var snapshot = Snapshot()
        snapshot.appendSections(viewModel.keys)
        viewModel.allContactModel.forEach { (key: String, value: [ContactModel]) in
            snapshot.appendItems(value, toSection: key)
        }
        if let _ = indexPath, let section = indexPath?.section {
            snapshot.reloadSections([viewModel.keys[section]])
        }
        self.dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
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
    
    private func editContact(indexPath: IndexPath) {
        guard let contactModel = self.viewModel.allContactModel[self.viewModel.keys[indexPath.section]]?[indexPath.row] else {
            return
        }
        let contactAddVM = ContactAddVM()
        contactAddVM.shouldEdit = true
        if let contactM = contactModel.copy() as? ContactModel {
            contactAddVM.contactModel = contactM
        }
        let vc = ContactAddVC()
        vc.viewModel = contactAddVM
        vc.didComplete = {[weak self] complete in
            if complete {
                self?.loadData(indexPath: indexPath)
            }
        }
        let nvc = UINavigationController(rootViewController: vc)
        self.present(nvc, animated: true)
    }
    
    private func deleteContact(indexPath: IndexPath) {
        viewModel.deleteContact(indexPath: indexPath)
        self.applySnapshot()
        self.handleEmptyData()
    }
    
    private func handleSearch() {
        searchBar.resignFirstResponder()
        loadData()
    }
    
    private func handleEmptyData() {
        hintLbl.isHidden = (viewModel.allContactModel.count) != 0
    }

}

extension ContactListVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editAction = UIContextualAction(style: .normal, title: "Edit", handler: {[weak self] (_, _, success) in
            if let self = self {
                self.editContact(indexPath: indexPath)
            }
            success(true)
        })
        
        return UISwipeActionsConfiguration(actions: [editAction])
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editAction = UIContextualAction(style: .destructive, title: "Delete", handler: {[weak self] (_, _, success) in
            if let self = self {
                self.deleteContact(indexPath: indexPath)
            }
            success(true)
        })
        
        return UISwipeActionsConfiguration(actions: [editAction])
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
