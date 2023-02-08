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
    
    func updateContact(contactModel: ContactModel) {
        try? realm?.write({
            realm?.add(contactModel, update: .modified)
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
    
    func getAllContact(where text: String) -> [ContactModel]? {
        if let contactModels = realm?.objects(ContactModel.self).where({
            $0.firstName.contains(text) || $0.lastName.contains(text) || $0.mobNumber.contains(text)
        }).sorted(byKeyPath: "firstName", ascending: true).sorted(byKeyPath: "lastName", ascending: true) {
            return Array(contactModels)
        }
        return nil
    }
    
    func deleteContact(contactModel: ContactModel) {
        try? realm?.write({
            realm?.delete(contactModel)
        })
    }
    
}
