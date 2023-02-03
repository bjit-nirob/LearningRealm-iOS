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
    var allContactModel = Dictionary<String, Array<ContactModel>>()//[String: [ContactModel]] = [:]
    
    init() {
        contactModel = ContactModel()
    }
    
    func saveContact() {
        if let contactModel = contactModel {
            RealmManager.shared.addContactModel(contactModel: contactModel)
        }
    }
    
    func loadContact() {
        contactModel = RealmManager.shared.getContactModel()
    }
    
    func loadAllContact() {
        allContactModel.removeAll()
        let contactModels = RealmManager.shared.getAllContactModel()
        contactModels?.forEach({ contactModel in
            let key = String(contactModel.firstName?.first ?? "Z")
            print("Key:: \(key)")
            if allContactModel[key] != nil {
                self.allContactModel[key]?.append(contactModel)
            } else {
                self.allContactModel[key] = [contactModel]
            }
        })
    }
}
