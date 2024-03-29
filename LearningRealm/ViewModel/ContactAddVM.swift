//
//  ContactAddVM.swift
//  LearningRealm
//
//  Created by BJIT on 8/2/23.
//

import Foundation

class ContactAddVM {
    var contactModel: ContactModel!
    var shouldEdit: Bool!
    
    init() {
        contactModel = ContactModel()
        shouldEdit = false
    }
    
    func saveContact() {
        if let contactModel = contactModel {
            RealmManager.shared.addContact(contactModel: contactModel)
        }
    }
    
    func updateContact() {
        if let contactModel = contactModel {
            RealmManager.shared.updateContact(contactModel: contactModel)
        }
    }
    
    func shouldSave() -> Bool {
        if let contactModel = contactModel, contactModel.firstName?.isEmpty == false, contactModel.lastName?.isEmpty == false, contactModel.mobNumber?.isEmpty == false {
            return true
        }
        return false
    }
}
