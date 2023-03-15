//
//  KeychainManager.swift
//  LearningRealm
//
//  Created by BJIT on 27/2/23.
//

import Foundation

class KeychainManager {
    enum KeychainError: Error {
        case itemNotFound
        case duplicateItem
        case invalidItemFormat
        // Any operation result status than errSecSuccess
        case unexpectedStatus(OSStatus)
    }
    
    static let shared = KeychainManager()
    
    private let service = (Bundle.main.bundleIdentifier ?? "app") + ".service"
    private lazy var query: [String: Any] = [
        String(kSecAttrService): self.service,
        String(kSecClass): kSecClassGenericPassword
    ]
    
    func save(for key: String, value: String) throws {
        guard let encodedValue = value.data(using: .utf8) else {
            throw KeychainError.invalidItemFormat
        }
        var query: [String: Any] = self.query
        query[String(kSecAttrAccount)] = key
        
        var status = SecItemCopyMatching(query as CFDictionary, nil)
        
        switch status {
        case errSecSuccess:
            // attributes is passed to SecItemUpdate with
            // kSecValueData as the updated item value
            let attributes: [String: Any] = [String(kSecValueData): encodedValue]
            status = SecItemUpdate(query as CFDictionary, attributes as CFDictionary)
            if status != errSecSuccess {
                throw KeychainError.unexpectedStatus(status)
            }
        case errSecItemNotFound:
            // kSecValueData is the item value to save
            query[String(kSecValueData)] = encodedValue
            status = SecItemAdd(query as CFDictionary, nil)
            if status != errSecSuccess {
                throw KeychainError.unexpectedStatus(status)
            }
        default:
            throw KeychainError.unexpectedStatus(status)
        }
        
        // SecItemAdd attempts to add the item identified by
        // the query to keychain
        
        // errSecDuplicateItem is a special case where the
        // item identified by the query already exists. Throw
        // duplicateItem so the client can determine whether
        // or not to handle this as an error
        if status == errSecDuplicateItem {
            throw KeychainError.duplicateItem
        }

        // Any status other than errSecSuccess indicates the
        // save operation failed.
        guard status == errSecSuccess else {
            throw KeychainError.unexpectedStatus(status)
        }
    }
    
    func get(for key: String) throws -> String? {
        var query: [String: Any] = self.query
        query[String(kSecAttrAccount)] = key
        query[String(kSecMatchLimit)] = kSecMatchLimitOne
        query[String(kSecReturnData)] = kCFBooleanTrue

        // SecItemCopyMatching will attempt to copy the item
        // identified by query to the reference itemCopy
        var itemCopy: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &itemCopy)

        // errSecItemNotFound is a special status indicating the
        // read item does not exist. Throw itemNotFound so the
        // client can determine whether or not to handle
        // this case
        guard status != errSecItemNotFound else {
            throw KeychainError.itemNotFound
        }
        
        // Any status other than errSecSuccess indicates the
        // read operation failed.
        guard status == errSecSuccess else {
            throw KeychainError.unexpectedStatus(status)
        }

        // This implementation of KeychainInterface requires all
        // items to be saved and read as Data. Otherwise,
        // invalidItemFormat is thrown
        guard let password = itemCopy as? Data else {
            throw KeychainError.invalidItemFormat
        }

        return String(data: password, encoding: .utf8)
    }
    
    func delete(key: String) throws {
        var query: [String: Any] = self.query
        query[String(kSecAttrAccount)] = key

        // SecItemDelete attempts to perform a delete operation
        // for the item identified by query. The status indicates
        // if the operation succeeded or failed.
        let status = SecItemDelete(query as CFDictionary)

        // Any status other than errSecSuccess indicates the
        // delete operation failed.
        guard status == errSecSuccess || status == errSecItemNotFound else {
            throw KeychainError.unexpectedStatus(status)
        }
    }
    
    func deleteAll() throws {
        let query: [String: Any] = self.query

        // SecItemDelete attempts to perform a delete operation
        // for the item identified by query. The status indicates
        // if the operation succeeded or failed.
        let status = SecItemDelete(query as CFDictionary)

        // Any status other than errSecSuccess indicates the
        // delete operation failed.
        guard status == errSecSuccess || status == errSecItemNotFound else {
            throw KeychainError.unexpectedStatus(status)
        }
    }
}
