//
//  TestViewModel.swift
//  LearningRealm
//
//  Created by BJIT on 13/1/23.
//

import Foundation

class ContactViewModel {
    var contactModel: ContactModel?
    let alphabet: [String] = (65...90).map({String(UnicodeScalar($0))})
    var allContactModel: [String: [ContactModel]] = [:]
    var keys: [String]
    
    init() {
        contactModel = ContactModel()
        keys = []
    }
    
    func saveContact() {
        if let contactModel = contactModel {
            RealmManager.shared.addContact(contactModel: contactModel)
        }
    }
    
    func loadContact(primaryKey: String) {
        contactModel = RealmManager.shared.getContact(primaryKey: primaryKey)
    }
    
    func loadAllContact() {
        allContactModel.removeAll()
        keys.removeAll()
        let contactModels = RealmManager.shared.getAllContact()
        contactModels?.forEach({ contactModel in
            let key = String(contactModel.firstName?.first ?? "Z")
            print("Key:: \(key)")
            if allContactModel[key] != nil {
                allContactModel[key]?.append(contactModel)
            } else {
                keys.append(key)
                allContactModel[key] = [contactModel]
            }
        })
    }
    
    func deleteContact(contactModel: ContactModel) {
        RealmManager.shared.deleteContact(contactModel: contactModel)
    }
}
