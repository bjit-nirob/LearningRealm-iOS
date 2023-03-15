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
    var app: App?
    
    init() {
        do {
            realm = try? Realm()
            print("Realm path:: \(realm?.configuration.fileURL?.absoluteString ?? "no path")")
        }
        
        app = App(id: AppConstants.realmAppId)
    }
    
    func addContact(contactModel: ContactModel) {
        print("LR test:: contactId: \(contactModel._id)")
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
    
    @MainActor
    func sync() {
        if let currentUser = app?.currentUser {
            Task.init(operation: {
                await self.openSyncedRealm(user: currentUser)
            })
            print("currentUser.accessToken \(currentUser.id)")
        } else {
            app?.login(credentials: .anonymous) { result in
                switch result {
                case .success(let user):
                    print("got user \(user.id)")
                    Task.init(operation: {
                        await self.openSyncedRealm(user: user)
                    })
                case .failure(let error):
                    print("got error \(error.localizedDescription)")
                }
            }
        }
        
    }
    
    // Opening a realm and accessing it must be done from the same thread.
    // Marking this function as `@MainActor` avoids threading-related issues.
    @MainActor
    func openSyncedRealm(user: User) async {
        do {
            var config = user.flexibleSyncConfiguration()
            // Pass object types to the Flexible Sync configuration
            // as a temporary workaround for not being able to add a
            // complete schema for a Flexible Sync app.
            config.objectTypes = [ContactModel.self]
            let realm = try await Realm(configuration: config, downloadBeforeOpen: .always)
            // You must add at least one subscription to read and write from a Flexible Sync realm
            let subscriptions = realm.subscriptions
            try await subscriptions.update {
                subscriptions.append(
                    QuerySubscription<ContactModel> {
                        print("LR test:: contactId sync: \($0.firstName.persistableValue)")
                        return $0.firstName != nil
                    })
            }
            self.realm = realm
//            useRealm(realm: realm, user: user)
        } catch {
            print("Error opening realm: \(error.localizedDescription)")
        }
    }
}
