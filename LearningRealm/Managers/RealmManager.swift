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
        }
    }
    
    func addContactModel(contactModel: ContactModel) {
        try? realm?.write({
            realm?.add(contactModel)
            print("Realm path:: \(realm?.configuration.fileURL)")
        })
    }
    
    func getContactModel() -> ContactModel? {
        let contactModel = realm?.objects(ContactModel.self).first
        return contactModel
    }
    
    func getAllContactModel() -> [ContactModel]? {
        if let contactModels = realm?.objects(ContactModel.self).sorted(byKeyPath: "firstName", ascending: true) {
            return Array(contactModels)
        }
        return nil
    }
    
}
