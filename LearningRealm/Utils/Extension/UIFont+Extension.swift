//
//  UIFont+Extension.swift
//  Loop
//
//  Created by mac 2019 on 2/10/22.
//

import Foundation
import UIKit

extension UIFont {
    static func InterRegular(ofSize: CGFloat) -> UIFont {
        return UIFont(name: "Inter-Regular", size: ofSize)!
    }
    
    static func InterLight(ofSize: CGFloat) -> UIFont {
        return UIFont(name: "Inter-Light", size: ofSize)!
    }
    
    static func InterMedium(ofSize: CGFloat) -> UIFont {
        return UIFont(name: "Inter-Medium", size: ofSize)!
    }
    
    static func InterSemiBold(ofSize: CGFloat) -> UIFont {
        return UIFont(name: "Inter-SemiBold", size: ofSize)!
    }
    
    static func InterBold(ofSize: CGFloat) -> UIFont {
        return UIFont(name: "Inter-Bold", size: ofSize)!
    }
    
    static func InterExtraBold(ofSize: CGFloat) -> UIFont {
        return UIFont(name: "Inter-ExtraBold", size: ofSize)!
    }
}
