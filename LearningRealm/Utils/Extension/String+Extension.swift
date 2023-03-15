//
//  String+Extension.swift
//  LearningRealm
//
//  Created by BJIT on 13/1/23.
//

import Foundation
import UIKit

extension String {
    var tr: String {
        let selectedLanguageCode = AppManager.shared.getLanguageCode().rawValue
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
    
    /// Generates a `UIImage` instance from this string using a specified
        /// attributes and size.
        ///
        /// - Parameters:
        ///     - attributes: to draw this string with. Default is `nil`.
        ///     - size: of the image to return.
        /// - Returns: a `UIImage` instance from this string using a specified
        /// attributes and size, or `nil` if the operation fails.
        func image(withAttributes attributes: [NSAttributedString.Key: Any]? = nil, size: CGSize? = nil) -> UIImage? {
            let size = size ?? (self as NSString).size(withAttributes: attributes)
            return UIGraphicsImageRenderer(size: size).image { _ in
                (self as NSString).draw(in: CGRect(origin: CGPoint(x: 5.s, y: 5.s), size: size),
                                        withAttributes: attributes)
            }
        }
}
