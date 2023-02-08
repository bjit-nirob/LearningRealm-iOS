//
//  TestViewModel.swift
//  LearningRealm
//
//  Created by BJIT on 13/1/23.
//

import Foundation

class ContactListVM {
    enum Section {
        case main
    }
    
    let alphabet: [String] = (65...90).map({String(UnicodeScalar($0))})
    var allContactModel: [String: [ContactModel]] = [:]
    var keys: [String] = []
    var searchText: String = ""
    
    init() {
        
    }
    
    func getContact(primaryKey: String) -> ContactModel? {
        let contactModel = RealmManager.shared.getContact(primaryKey: primaryKey)
        return contactModel
    }
    
    func loadAllContact() {
        allContactModel.removeAll()
        keys.removeAll()
        let contactModels = searchText.isEmpty ? RealmManager.shared.getAllContact() : RealmManager.shared.getAllContact(where: searchText)
        contactModels?.forEach({ contactModel in
            let key = String(contactModel.firstName?.first ?? "Z")
            if allContactModel[key] != nil {
                allContactModel[key]?.append(contactModel)
            } else {
                keys.append(key)
                allContactModel[key] = [contactModel]
            }
        })
    }
    
    func deleteContact(contactModel: ContactModel) {
        allContactModel.forEach { (key, _) in
            allContactModel[key]?.removeAll {
                $0.contactId == contactModel.contactId
            }
            if allContactModel[key]?.isEmpty == true {
                keys.removeAll {
                    $0 == key
                }
                allContactModel.removeValue(forKey: key)
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            RealmManager.shared.deleteContact(contactModel: contactModel)
        }
    }
}
