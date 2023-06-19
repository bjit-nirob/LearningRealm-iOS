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
    private var initializationComplete: ((Bool) -> Void)?
    
    init() {
        app = App(id: AppConstants.realmAppId)
    }
    
    func initialize(completion: @escaping (Bool) -> Void) {
        self.initializationComplete = completion
        realm = try? Realm()
        print("Realm path:: \(realm?.configuration.fileURL?.absoluteString ?? "no path")")
        
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
                    self.initializationComplete?(false)
                }
            }
        }
    }
    
    // Opening a realm and accessing it must be done from the same thread.
    // Marking this function as `@MainActor` avoids threading-related issues.
    @MainActor
    func openSyncedRealm(user: User) async {
        let configuration = user.flexibleSyncConfiguration(initialSubscriptions: { subscription in
            if subscription.first(named: "all-contacts") != nil {
                return
            } else {
                subscription.append(QuerySubscription<ContactModel>(name: "all-contacts"))
            }
        }, rerunOnOpen: true)
        self.realm = try? await Realm(configuration: configuration, downloadBeforeOpen: .always)
        self.initializationComplete?(true)
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
}
