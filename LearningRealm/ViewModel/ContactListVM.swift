//
//  TestViewModel.swift
//  LearningRealm
//
//  Created by BJIT on 13/1/23.
//

import Foundation

class ContactListVM {
    enum Section {
        case main
    }
    var alphabet: [String] = (65...90).map({String(UnicodeScalar($0))})
    /*{
        return AppManager.shared.getLanguageCode() == .bn ? ["অ", "আ", "ই", "ঈ", "উ", "ঊ", "ঋ", "এ", "ঐ", "ও", "ঔ", "ক", "খ", "গ", "ঘ", "ঙ", "চ", "ছ", "জ", "ঝ", "ঞ", "ট", "ঠ", "ড", "ঢ", "ণ", "ত", "থ", "দ", "ধ", "ন", "প", "ফ", "ব", "ভ", "ম", "য", "র", "ল", "শ", "ষ", "স", "হ", "ড়", "ঢ়", "য়"] : (65...90).map({String(UnicodeScalar($0))})
    }()*/
    var allContactModel: [String: [ContactModel]] = [:]
    var keys: [String] = []
    var searchText: String = ""
    
    init() {
        
    }
    
    func getContact(primaryKey: String) -> ContactModel? {
        let contactModel = RealmManager.shared.getContact(primaryKey: primaryKey)
        return contactModel
    }
    
    func loadAllContact() {
        allContactModel.removeAll()
        keys.removeAll()
        let contactModels = searchText.isEmpty ? RealmManager.shared.getAllContact() : RealmManager.shared.getAllContact(where: searchText)
        contactModels?.forEach({ contactModel in
            let key = String(contactModel.firstName?.first ?? "Z")
            if allContactModel[key] != nil {
                allContactModel[key]?.append(contactModel)
            } else {
                keys.append(key)
                allContactModel[key] = [contactModel]
            }
        })
    }
    
    func deleteContact(indexPath: IndexPath) {
        guard let contactModel = allContactModel[keys[indexPath.section]]?[indexPath.row] else {
            return
        }
        allContactModel[keys[indexPath.section]]?.remove(at: indexPath.row)
        if allContactModel[keys[indexPath.section]]?.isEmpty == true {
            allContactModel.removeValue(forKey: keys[indexPath.section])
            keys.remove(at: indexPath.section)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            RealmManager.shared.deleteContact(contactModel: contactModel)
        }
    }
}
