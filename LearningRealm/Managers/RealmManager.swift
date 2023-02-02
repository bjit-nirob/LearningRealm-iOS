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
    
    func addData(contactModel: ContactModel) {
        
    }
}
