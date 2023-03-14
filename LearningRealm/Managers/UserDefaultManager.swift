//
//  UserDefaultManager.swift
//  LearningRealm
//
//  Created by BJIT on 27/2/23.
//

import Foundation

class UserDefaultManager {
    static let shared = UserDefaultManager()
    
    private var userDefauls = UserDefaults.standard
    
    init() {
        
    }
    
    func save<T>(key: String, value: T) {
        userDefauls.set(value, forKey: key)
        userDefauls.synchronize()
    }
    
    func get<T>(for key: String, ofType: T.Type) -> T? {
        let value = userDefauls.value(forKey: key)
        return value as? T
    }
    
    func save(for key: String, value: Int) {
        save(key: key, value: value)
    }
    
    func int(key: String) -> Int {
        return get(for: key, ofType: Int.self) ?? 0
    }
    
    func save(for key: String, value: Double) {
        save(key: key, value: value)
    }
    
    func double(key: String) -> Double {
        return get(for: key, ofType: Double.self) ?? 0.0
    }
    
    func save(for key: String, value: Float) {
        save(key: key, value: value)
    }
    
    func float(key: String) -> Float {
        return get(for: key, ofType: Float.self) ?? 0.0
    }
    
    func save(for key: String, value: String) {
        save(key: key, value: value)
    }
    
    func string(key: String) -> String {
        return get(for: key, ofType: String.self) ?? ""
    }
}
