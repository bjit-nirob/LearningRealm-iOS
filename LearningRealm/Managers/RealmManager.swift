//
//  RealmManager.swift
//  LearningRealm
//
//  Created by BJIT on 13/1/23.
//

import Foundation
import RealmSwift

final class RealmManager {
    static let shared = RealmManager()
    var realm: Realm?
    init() {
        do {
            realm = try? Realm()
            print("Realm path:: \(realm?.configuration.fileURL?.absoluteString ?? "no path")")
        }
    }
    
    func addContact(contactModel: ContactModel) {
        try? realm?.write({
            realm?.add(contactModel)
        })
    }
    
    func getContact(primaryKey: String) -> ContactModel? {
        let contactModel = realm?.object(ofType: ContactModel.self, forPrimaryKey: primaryKey)
        return contactModel
    }
    
    func getAllContact() -> [ContactModel]? {
        if let contactModels = realm?.objects(ContactModel.self).sorted(byKeyPath: "firstName", ascending: true) {
            return Array(contactModels)
        }
        return nil
    }
    
    func deleteContact(contactModel: ContactModel) {
        try? realm?.write({
            if let contactM = getContact(primaryKey: contactModel.contactId) {
                realm?.delete(contactM)
            }
        })
    }
    
}
