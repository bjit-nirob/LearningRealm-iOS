//
//  ContactListDiffableDataSource.swift
//  LearningRealm
//
//  Created by BJIT on 8/2/23.
//

import Foundation
import UIKit

class ContactListDiffableDataSource: UITableViewDiffableDataSource<String, ContactModel> {
    var viewModel: ContactListVM!
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.keys[section]
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return viewModel.alphabet
    }
}
