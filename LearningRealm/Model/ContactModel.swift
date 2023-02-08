//
//  ContactModel.swift
//  LearningRealm
//
//  Created by BJIT on 2/2/23.
//

import Foundation
import RealmSwift

class ContactModel: Object, NSCopying {
    @Persisted(primaryKey: true) var contactId: String = UUID().uuidString
    @Persisted var imageUrl: String?
    @Persisted var firstName: String?
    @Persisted var lastName: String?
    @Persisted var mobNumber: String?
    
    func copy(with zone: NSZone? = nil) -> Any {
        let contactModel = ContactModel()
        contactModel.contactId = self.contactId
        contactModel.imageUrl = self.imageUrl
        contactModel.firstName = self.firstName
        contactModel.lastName = self.lastName
        contactModel.mobNumber = self.mobNumber
        return contactModel
    }
}
