//
//  String+Extension.swift
//  LearningRealm
//
//  Created by BJIT on 13/1/23.
//

import Foundation

extension String {
    var tr: String {
        let selectedLanguageCode = "en"// AppManager.shared.getLanguageCode()
        if let path = Bundle.main.path(forResource: selectedLanguageCode, ofType: "lproj"), let bundle = Bundle(path: path) {
            return NSLocalizedString(self, tableName: "Localizable", bundle: bundle, value: self, comment: self)
        }
        return NSLocalizedString(self, tableName: "Localizable", bundle: .main, value: self, comment: self)
    }
    
    func convertTo(informat: String, outformat: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.calendar = Calendar.current
        dateFormatter.dateFormat = informat
        let date = dateFormatter.date(from: self)
        if let date = date {
            let dateStr = date.toString(format: outformat)
            return dateStr
        }
        return nil
    }
}
