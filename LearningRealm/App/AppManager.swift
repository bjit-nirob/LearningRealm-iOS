//
//  AppManager.swift
//  LearningRealm
//
//  Created by BJIT on 13/1/23.
//

import Foundation
import UIKit

enum Language: String {
    case en
    case bn
}

final class AppManager {
    static let shared = AppManager()
    
    var isDarkMode: Bool {
        if let window = UIApplication.shared.windows.first {
            return window.traitCollection.userInterfaceStyle == .dark
        }
        return false
    }
    
    var traitCollection: UITraitCollection? {
        if let window = UIApplication.shared.windows.first {
            return window.traitCollection
        }
        return nil
    }
    
    init() {
        
    }
    
    func getLanguageCode() -> Language {
        return .bn
    }
    
}
