//
//  Others+Extension.swift
//  LearningRealm
//
//  Created by BJIT on 2/2/23.
//

import Foundation
import UIKit

extension Date {
    func toString(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.calendar = Calendar.current
        dateFormatter.dateFormat = format
        let str = dateFormatter.string(from: self)

        return str
    }
}

extension NSObject {
    static var identifier: String {
        return String(describing: self)
    }
}
