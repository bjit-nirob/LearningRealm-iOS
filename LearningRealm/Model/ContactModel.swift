//
//  ContactModel.swift
//  LearningRealm
//
//  Created by BJIT on 2/2/23.
//

import Foundation
import RealmSwift

class ContactModel: Object {
    @Persisted(primaryKey: true) var contactId: String = UUID().uuidString
    @Persisted var imageUrl: String?
    @Persisted var firstName: String?
    @Persisted var lastName: String?
    @Persisted var mobNumber: String?
}
